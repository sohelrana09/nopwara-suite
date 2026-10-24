The Nopwara theme and all nine Nopwara plugins in one upload for nopCommerce **5.00** and **4.90.8**.

**Install:** download the zip for your nopCommerce version below, then follow the [install steps](https://github.com/sohelrana09/nopwara-suite#install). Already on an earlier version? Upload the new zip and restart; plugins update themselves. The theme folder has to be replaced by hand (see [Update](https://github.com/sohelrana09/nopwara-suite#update)).

| Zip | For |
|---|---|
| `nopwara-suite-1.3.0-nop5.00.zip` | nopCommerce 5.00 |
| `nopwara-suite-1.3.0-nop4.90.zip` | nopCommerce 4.90.8 |

## What's new in v1.3.0: faster than DefaultClean

On a 500-product test store, Nopwara now matches or beats nopCommerce's DefaultClean on every page we measured with Lighthouse: home, category, product and search, on desktop and mobile. It downloads less on every page, and it has no layout shift on desktop or on category and product pages.

**Theme**
- **Menus cost nothing until they open.** The mobile menu is built in the browser from the desktop menu the first time the drawer opens. Dropdown extras wait in `<template>` tags until a dropdown opens.
- **One cached icon sprite** (`Content/icons.svg`) replaces dozens of inline SVGs, and short component classes replace long repeated utility lists. A category page's HTML went from about 241 KB to about 176 KB.
- **About 77 KB less JavaScript (gzipped) on most pages:** jQuery UI now loads only when a page uses one of its widgets, and jQuery Migrate is gone. No script blocks the first paint any more.
- **Images:** `srcset`/`sizes`, `width`/`height`, eager loading for the first row of products, and `fetchpriority` for the main product picture. On the home page, the first slide of nopCommerce's slider is preloaded and its height is reserved, so nothing jumps. If your slides aren't 1200 × 500, set `nopwarathemesettings.sliderratio` (e.g. `1600 / 560`) in All settings.
- **Hover prefetch:** pages start loading when the pointer rests on a link, in Chromium browsers. Cart, checkout and account links are excluded.
- **No layout shift from the menu bar** (compact mode is decided before the first paint) or from the search page's advanced-search toggle, which is now Alpine instead of jQuery.
- **Speed budget in CI:** every push to the theme builds a sample store and runs Lighthouse against fixed limits on the score, LCP, CLS, blocking time, script/CSS/HTML size and DOM size, for both 5.00 and 4.90. A change that makes the theme slower fails the check.

**Plugins**
- [Mega menu](https://github.com/sohelrana09/nopwara-mega-menu) 1.03: passes icon names, so themes can use an icon sprite.
- [Quick view](https://github.com/sohelrana09/nopwara-quick-view) 1.01 and [Instant search](https://github.com/sohelrana09/nopwara-instant-search) 1.01: their scripts load in the footer instead of blocking the first paint. Instant search also avoids a nopCommerce minifier bug that could break the whole script bundle.

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
