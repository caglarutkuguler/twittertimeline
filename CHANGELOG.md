# Changelog

All notable changes to **Twitter and X Feed Widget** (`twittertimeline`).

## 4.2.1

### Fixed

- **The back-office icons turned into empty boxes on PrestaShop 9.** The 9
  icons the module draws for itself came from FontAwesome 4, which the back
  office shipped up to PrestaShop 8. PrestaShop 9 replaced it with Material
  Symbols Outlined, and FontAwesome now reaches the page only through
  `themes/default/public/theme.css` — a leftover of the old theme rather than
  anything the new back office asks for.

  An icon-font class does not name a picture; it selects a private-use code
  point that means nothing without that exact font file. So the moment the
  font is not there the browser has nothing to fall back to and draws a
  placeholder box. That makes the failure abrupt rather than gradual, and it
  shows up first on a page load with a freshly cleared asset cache.

  The icons now come from the set the core loads for its own interface, where
  the icon name is the element’s text rather than a class. They are sized
  down from its 24px default and set back to inheriting the surrounding text
  colour, so they sit exactly where the FontAwesome ones did. Nothing in the
  interface moves or changes name.

  The two Twitter marks are the exception: Material Symbols carries no brand
  icons, so those are now a small inline SVG of the X logo drawn in the
  surrounding text colour, which depends on no font at all.

## 4.2.0

### Added

- A single review-request line on the module's own configuration page. It
  appears at the earliest 21 days after installing, asks once for a short
  review on megventure.com, and disappears forever after a click, a
  "No thanks", or three unanswered views. It makes no outbound request of any
  kind and stores nothing beyond three prefixed configuration values, which
  uninstalling removes.

## 4.1.1

### Fixed

- **Upgrade could disable the module on some shops.** The 4.0.1 upgrade
  step's success hinged directly on a `registerHook()` call returning true;
  a transient failure there (or the hook already being registered from a
  partial prior attempt) marked the whole upgrade step failed and
  PrestaShop disabled the module. The hook is now registered idempotently
  and the step always reports success.
