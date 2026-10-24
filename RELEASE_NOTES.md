The Nopwara theme and all nine Nopwara plugins in one upload for nopCommerce **5.00** and **4.90.8**.

**Install:** download the zip for your nopCommerce version below, then follow the [install steps](https://github.com/sohelrana09/nopwara-suite#install). Already on an earlier version? Upload the new zip and restart; plugins update themselves. The theme folder has to be replaced by hand (see [Update](https://github.com/sohelrana09/nopwara-suite#update)).

| Zip | For |
|---|---|
| `nopwara-suite-1.4.2-nop5.00.zip` | nopCommerce 5.00 |
| `nopwara-suite-1.4.2-nop4.90.zip` | nopCommerce 4.90.8 |

## What's new in v1.4.2

- **Fix:** pages with a product carousel (home page, related products) no longer scroll sideways or show an extra scrollbar. Hidden screen-reader labels inside the carousel cards were stretching the page wider than the window.

## What's new in v1.4.1: paged reviews and Q&A

Product pages with many reviews or questions no longer get very long.

- **Reviews are paged:** 5 per page, with page numbers and "1–5 of 42". Reviews on later pages aren't added to the page until their page is opened, so even products with hundreds of reviews stay light. Change the page size with `nopwarathemesettings.reviewspagesize`.
- **Questions are paged too** ([Product Q&A](https://github.com/sohelrana09/nopwara-product-qa) 1.01): the "Show all" button is replaced by a pager. The plugin's "Questions shown" setting is now "Questions per page" (default 5). All questions stay in the page for search engines and the FAQ structured data.
- **Fix:** review "helpful? yes / no" votes now work for every review. Before, their scripts failed for reviews on later pages.

## What's new in v1.4.0: no jQuery, image zoom, carousels

**Theme**
- **No jQuery.** The theme no longer loads jQuery, jQuery UI, jQuery Migrate, jquery.validate or nopCommerce's `public.*.js` files. Every storefront view that used them is rewritten with Alpine.js and plain JavaScript, including the catalog, product page, cart, both checkouts, account, orders and wishlist. A small runtime, `Content/js/nopwara-core.js` (about 7 KB gzipped, against about 44 KB for the scripts it replaces), handles requests, form validation from nopCommerce's `data-val-*` attributes, dialogs, the ajax cart, catalog filters and product attribute changes.
- **Third-party plugins keep working.** nopCommerce's global helpers (`setLocation`, `AjaxCart`, `Billing`, `Checkout` and others) still exist as jQuery-free versions. If a plugin ships its own jQuery code (for example Misc.RFQ, PayPal Commerce or Avalara), jQuery loads only on the pages where that plugin's script uses it. For plugins that load their scripts later by ajax, set `nopwarathemesettings.jquerycompat` to `true` to load jQuery on every page.
- **Product image zoom.** Hover zoom on desktop; in the lightbox, pinch, double-tap or wheel to zoom, drag to pan and swipe to change picture. Requires "Picture zoom" to be enabled in the media settings.
- **Carousels:** featured products, bestsellers, related products and "also purchased" are swipeable rows with previous/next buttons. They use CSS scroll snapping, with no slider library.
- **Product ribbons:** a "-20%" ribbon when a product has an old price, and "New" for products marked as new.
- **Home trust strip,** built from your store's settings, so it only promises what the store actually does:
  - free delivery over a set amount (only when that setting is on);
  - returns (only when return requests are on);
  - secure checkout and customer support.

  Turn it off with `nopwarathemesettings.showtruststrip = false`.
- **Faster:** on our 500-product test store, mobile Lighthouse scores went up again, to 91 / 97 / 100 / 98 (home / category / product / search), against DefaultClean's 85 / 89 / 96 / 94.
- **CI:** a new check fails the build if jQuery code appears in the theme or on a rendered page.
- **Fixes:**
  - the product lightbox no longer opens under the header;
  - the order print page now uses the theme stylesheet (it linked a `print.css` that didn't exist).

**Plugins**
- [Single-page checkout](https://github.com/sohelrana09/nopwara-checkout) 1.12: no jQuery with the Nopwara theme. It also fixes a bug where guest checkout posted the login form instead of the checkout form when "show login on checkout" was on.
- [Quick view](https://github.com/sohelrana09/nopwara-quick-view) 1.02 and [Product bundles](https://github.com/sohelrana09/nopwara-bundles) 1.01: no jQuery with the Nopwara theme. With other themes, they fall back to jQuery as before.

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
