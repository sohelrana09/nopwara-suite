# Nopwara Suite for nopCommerce

The [Nopwara theme](https://github.com/sohelrana09/nopwara-theme) and all eight Nopwara plugins, compiled and packed into **one zip** for nopCommerce 5.00. Upload it once in admin instead of installing nine items one by one.

**Download:** [latest release](https://github.com/sohelrana09/nopwara-suite/releases/latest)

| Included | What it does |
|---|---|
| [Nopwara theme](https://github.com/sohelrana09/nopwara-theme) | Lightweight Tailwind CSS + Alpine.js storefront |
| [Single-page checkout](https://github.com/sohelrana09/nopwara-checkout) | Checkout on one page, with login, pickup in store, order options and "Buy now" |
| [Instant search](https://github.com/sohelrana09/nopwara-instant-search) | Search dropdown with products, categories and brands |
| [Quick view](https://github.com/sohelrana09/nopwara-quick-view) | Product modal on category and search pages |
| [Conversion widgets](https://github.com/sohelrana09/nopwara-boost) | Free-shipping bar, sale countdown, low stock, sticky add to cart |
| [Product Q&A](https://github.com/sohelrana09/nopwara-product-qa) | Customer questions and answers on product pages |
| [Product bundles](https://github.com/sohelrana09/nopwara-bundles) | "Frequently bought together" with a bundle discount |
| [Webhooks](https://github.com/sohelrana09/nopwara-webhooks) | Signed webhooks for orders, customers and products |
| [Google sign-in](https://github.com/sohelrana09/nopwara-google-signin) | "Continue with Google" |

## Install

1. In admin, go to **Configuration → Local plugins → Upload plugin or theme** and upload `nopwara-suite-<version>.zip`.
   The archive holds a theme, so nopCommerce restarts itself. Hosts that don't restart stopped apps, such as `dotnet run`, need the site started again.
2. On the same page, click **Install** on each of the eight Nopwara plugins (each click only queues it), then click **Restart application** once.
3. Go to **Configuration → Settings → General settings** and choose **Nopwara** as the store theme.
4. Open the **Nopwara single-page checkout** plugin's configuration page and tick **Enabled**.
5. Optional:
   - add your Google OAuth keys to **Google sign-in** and enable it in Configuration → External authentication;
   - add endpoints in **Configuration → Webhooks**.

Each plugin README has the full list of settings.

## Update

Upload the new zip the same way, then restart. Plugins whose `plugin.json` version changed run their update step on restart.

nopCommerce won't upload a theme that already exists, so the upload ends with "A theme with 'Nopwara' system name is already defined". The plugins are still updated, because the theme comes last in the archive. To update the theme too, either:
- copy the `Themes/Nopwara` folder from the zip over `Themes/Nopwara` on the server, then restart the application, or
- delete `Themes/Nopwara` on the server, restart the application (nopCommerce reads the theme list at startup), then upload the zip.

## Build the zip yourself

You need Git, Python 3, rsync and the .NET 10 SDK.

```bash
./build.sh 1.0.0
```

The script:
1. downloads nopCommerce source at a pinned commit (the plugins reference Nop.Web);
2. clones the theme and plugin repos into it;
3. builds each plugin in Release;
4. writes `out/nopwara-suite-1.0.0.zip` with an `uploadedItems.json` that lists all nine items.

It packs only runtime files, with no symbols or `node_modules`.

| Variable | Default | Use |
|---|---|---|
| `NOP_REF` | the nopCommerce 5.00 `develop` commit the plugins were tested on | Set it to the final 5.00 release tag once nopCommerce publishes it |
| `NOP_REPO` | `https://github.com/nopSolutions/nopCommerce.git` | A fork or local path |
| `GITHUB_OWNER` | `sohelrana09` | Where the Nopwara repos live |
| `REPO_REF` | `main` | Branch or tag of the Nopwara repos |

## Releases

Push a tag and the **Release** workflow builds the zip and attaches it to a GitHub Release:

```bash
git tag v1.0.1
git push origin v1.0.1
```

To ship a plugin fix:
1. Commit it to the plugin's repo and bump `Version` in its `plugin.json`, so stores can update it.
2. Tag a new suite version.

## License

Copyright (C) 2026 Sohel Rana

Licensed under the [GNU Affero General Public License v3.0](LICENSE), like nopCommerce (the [nopCommerce Public License](https://www.nopcommerce.com/license) is AGPL v3 plus its additional terms). A store that uses it must keep nopCommerce's "Powered by nopCommerce" link.
