#!/usr/bin/env bash
#
# Builds nopwara-suite-<version>-nop<nopCommerce version>.zip: the Nopwara theme and the nine Nopwara plugins,
# compiled and packed for nopCommerce's multi-item upload (Admin > Configuration > Local plugins > "Upload plugin or theme").
#
#   ./build.sh 1.2.0                                                              # nopCommerce 5.00
#   NOP_VERSION=4.90 NOP_REF=release-4.90.8 REPO_REF=nop-4.90 ./build.sh 1.2.0    # nopCommerce 4.90 (needs the .NET 9 SDK)
#
# Plugins are compiled against nopCommerce source (they reference Nop.Web), so the script downloads it,
# clones every Nopwara repo into it, builds each plugin in Release and copies only the files a store needs.
#
# Environment overrides:
#   NOP_REPO      nopCommerce git repository (default: the official one; a local path works too)
#   NOP_REF       commit, tag or branch to build against (default: the develop commit the plugins were tested with)
#   GITHUB_OWNER  owner of the Nopwara repos (default: sohelrana09)
#   REPO_REF      branch or tag of the Nopwara repos (default: main; nop-4.90 holds the 4.90 port)
#   NOP_VERSION   nopCommerce version the zip is for: names the zip and fills uploadedItems.json (default: 5.00)

set -euo pipefail

VERSION="${1:-dev}"
NOP_REPO="${NOP_REPO:-https://github.com/nopSolutions/nopCommerce.git}"
NOP_REF="${NOP_REF:-77d112f365e210ebdfa2f9790c8202a0e3b1c74e}"
GITHUB_OWNER="${GITHUB_OWNER:-sohelrana09}"
REPO_REF="${REPO_REF:-main}"
NOP_VERSION="${NOP_VERSION:-5.00}"

ROOT="$(cd "$(dirname "$0")" && pwd)"
WORK="$ROOT/work"
NOP="$WORK/nopCommerce"
STAGE="$WORK/stage"
OUT="$ROOT/out"
ZIP="$OUT/nopwara-suite-$VERSION-nop$NOP_VERSION.zip"

# repo name, project folder (src/Plugins/<folder>)
PLUGINS=(
    "nopwara-checkout Nop.Plugin.Misc.NopwaraCheckout"
    "nopwara-instant-search Nop.Plugin.Widgets.NopwaraSearch"
    "nopwara-quick-view Nop.Plugin.Widgets.NopwaraQuickView"
    "nopwara-boost Nop.Plugin.Widgets.NopwaraBoost"
    "nopwara-product-qa Nop.Plugin.Misc.NopwaraQA"
    "nopwara-bundles Nop.Plugin.Misc.NopwaraBundles"
    "nopwara-webhooks Nop.Plugin.Misc.NopwaraWebhooks"
    "nopwara-google-signin Nop.Plugin.ExternalAuth.Google"
    "nopwara-mega-menu Nop.Plugin.Widgets.NopwaraMegaMenu"
)
THEME_REPO="nopwara-theme"

log() { printf '\n==> %s\n' "$*"; }

repo_url() {
    echo "https://github.com/$GITHUB_OWNER/$1.git"
}

rm -rf "$WORK"
mkdir -p "$WORK" "$STAGE/Plugins" "$STAGE/Themes" "$OUT"

log "nopCommerce source ($NOP_REF)"
git init -q "$NOP"
git -C "$NOP" fetch -q --depth 1 "$NOP_REPO" "$NOP_REF"
git -C "$NOP" -c advice.detachedHead=false checkout -q FETCH_HEAD

log "Nopwara repos ($GITHUB_OWNER, $REPO_REF)"
for entry in "${PLUGINS[@]}"; do
    read -r repo folder <<< "$entry"
    git clone -q --depth 1 --branch "$REPO_REF" "$(repo_url "$repo")" "$NOP/src/Plugins/$folder"
    echo "  $repo -> src/Plugins/$folder"
done
git clone -q --depth 1 --branch "$REPO_REF" "$(repo_url "$THEME_REPO")" "$NOP/src/Presentation/Nop.Web/Themes/Nopwara"
echo "  $THEME_REPO -> src/Presentation/Nop.Web/Themes/Nopwara"

log "Build plugins (Release)"
for entry in "${PLUGINS[@]}"; do
    read -r repo folder <<< "$entry"
    # plugin projects take their output path and Nop.Web reference from $(SolutionDir)
    dotnet build "$NOP/src/Plugins/$folder/$folder.csproj" -c Release -p:SolutionDir="$NOP/src/" -nologo -v quiet
done

log "Stage files"
items_json="["
separator=""
for entry in "${PLUGINS[@]}"; do
    read -r repo folder <<< "$entry"
    system_name="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1], encoding="utf-8-sig"))["SystemName"])' "$NOP/src/Plugins/$folder/plugin.json")"
    output="$NOP/src/Presentation/Nop.Web/Plugins/$system_name"
    [ -f "$output/plugin.json" ] || { echo "Build output not found: $output" >&2; exit 1; }

    # only what the store needs: no Nop.Web apphost/runtime files (left by the Nop.Web project reference) and no symbols
    rsync -a \
        --exclude 'Nop.Web' --exclude 'Nop.Web.*' --exclude '*.pdb' \
        "$output/" "$STAGE/Plugins/$system_name/"

    items_json+="$separator{\"Type\":\"Plugin\",\"SystemName\":\"$system_name\",\"SupportedVersion\":\"$NOP_VERSION\",\"DirectoryPath\":\"Plugins/$system_name/\"}"
    separator=","
    echo "  Plugins/$system_name"
done

rsync -a --exclude '.git' --exclude '.gitignore' --exclude 'node_modules' \
    "$NOP/src/Presentation/Nop.Web/Themes/Nopwara/" "$STAGE/Themes/Nopwara/"
items_json+=",{\"Type\":\"Theme\",\"SystemName\":\"Nopwara\",\"SupportedVersion\":\"$NOP_VERSION\",\"DirectoryPath\":\"Themes/Nopwara/\"}]"
echo "  Themes/Nopwara"

python3 -c 'import json,sys; json.dump(json.loads(sys.argv[1]), open(sys.argv[2], "w"), indent=2)' "$items_json" "$STAGE/uploadedItems.json"

log "Pack $ZIP"
rm -f "$ZIP"
# zip with forward-slash entry names and explicit directory entries (what nopCommerce's upload expects)
python3 - "$STAGE" "$ZIP" <<'PY'
import os, sys, zipfile
stage, target = sys.argv[1], sys.argv[2]
with zipfile.ZipFile(target, "w", zipfile.ZIP_DEFLATED) as archive:
    for directory, folders, files in os.walk(stage):
        folders.sort()
        relative = os.path.relpath(directory, stage).replace(os.sep, "/")
        if relative != ".":
            archive.writestr(relative + "/", "")
        for name in sorted(files):
            if name == ".DS_Store":
                continue
            path = os.path.join(directory, name)
            archive.write(path, os.path.relpath(path, stage).replace(os.sep, "/"))
PY

ls -lh "$ZIP"
