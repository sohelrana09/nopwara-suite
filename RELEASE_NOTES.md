The Nopwara theme and all nine Nopwara plugins in one upload for nopCommerce **5.00** and, new in this release, **4.90.8**.

**Install:** download the zip for your nopCommerce version below, then follow the [install steps](https://github.com/sohelrana09/nopwara-suite#install). Already on an earlier version? Upload the new zip and restart; plugins update themselves (see [Update](https://github.com/sohelrana09/nopwara-suite#update)).

| Zip | For |
|---|---|
| `nopwara-suite-1.2.0-nop5.00.zip` | nopCommerce 5.00 |
| `nopwara-suite-1.2.0-nop4.90.zip` | nopCommerce 4.90.8 |

## What's new in v1.2.0

**nopCommerce 4.90 support.** The theme and all nine plugins now also run on nopCommerce 4.90.8 (the `nop-4.90` branch of each repo). A few 5.00-only features are left out there: login by phone, desired delivery date, search history, product 3D models and the per-vendor cart.

**Faster pages with rich mega menus.** Dropdown products now load when a dropdown first opens, and panel pictures likewise. With nine rich dropdowns this cut server time from about 300 ms to about 100 ms per page and removed ~500 KB of images from every page view ([Mega menu](https://github.com/sohelrana09/nopwara-mega-menu) 1.02).

**Theme**
- Colour presets: set `nopwarathemesettings.colorpreset` to `medical` for a clinical teal palette (see the [theme README](https://github.com/sohelrana09/nopwara-theme#colour-presets)).
- Fixed: on phones the desktop menu showed and the menu drawer was broken on nopCommerce 4.90, whose CSS minifier mangled the theme's media queries. The stylesheet is now `styles.min.css`, which nopCommerce serves as-is.
- Fixed: the admin bar covered the mobile menu drawer's header for logged-in admins.
- Many top-level menu items now fit: titles stay on one line and the bar switches to a compact mode instead of wrapping words.
- Dropdown links use as many columns as the space next to the extra columns allows.

**Plugins**
- [Mega menu](https://github.com/sohelrana09/nopwara-mega-menu) 1.02: on-demand products, four new health icons (beaker, plus-circle, shield-check, face-smile), 3 featured products in one row.
- [Single-page checkout](https://github.com/sohelrana09/nopwara-checkout) 1.11: its stylesheet ships as `.min.css` for the same 4.90 minifier issue.

| Included | Repo |
|---|---|
| Nopwara theme | [nopwara-theme](https://github.com/sohelrana09/nopwara-theme) |
| Single-page checkout | [nopwara-checkout](https://github.com/sohelrana09/nopwara-checkout) |
| Instant search | [nopwara-instant-search](https://github.com/sohelrana09/nopwara-instant-search) |
| Quick view | [nopwara-quick-view](https://github.com/sohelrana09/nopwara-quick-view) |
| Conversion widgets | [nopwara-boost](https://github.com/sohelrana09/nopwara-boost) |
| Product Q&A | [nopwara-product-qa](https://github.com/sohelrana09/nopwara-product-qa) |
| Product bundles | [nopwara-bundles](https://github.com/sohelrana09/nopwara-bundles) |
| Webhooks | [nopwara-webhooks](https://github.com/sohelrana09/nopwara-webhooks) |
| Google sign-in | [nopwara-google-signin](https://github.com/sohelrana09/nopwara-google-signin) |
| Mega menu | [nopwara-mega-menu](https://github.com/sohelrana09/nopwara-mega-menu) |
