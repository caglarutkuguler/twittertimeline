# Changelog

All notable changes to **Twitter and X Feed Widget** (`twittertimeline`).

## Unreleased

### Fixed

- **The module shipped seven locale files that were almost entirely English.**
  `tr`, `fr`, `es`, `de`, `it`, `nl` and `pl` were each present, correctly
  named, and carried the complete 162-key set with every key hash matching
  `en.php` — so every structural check passed. But 156 of those 162 values
  were the English source text, copied verbatim. Only 6 strings had ever been
  translated, and 4 of those were the shared review-prompt text that every MEG
  module embeds, leaving **2 strings** of the module's own interface translated
  per language.

  The reason this lasted is worth recording: a locale file's *keys* are what
  the usual checks compare, and the keys were perfect. Nothing about a file
  full of English is structurally wrong, so file-exists, name, key-count and
  hash checks all pass. Only reading the values finds it.

  All 156 are now translated in all seven languages. The module's own copy —
  configuration page, validation messages, troubleshooting answers, and the
  storefront button and popup — now renders in the merchant's and shopper's
  language.

  No key changed, because a legacy PrestaShop key embeds `md5()` of the
  *English* source string; only values were rewritten. Verified with `php -l`
  on all nine files, by loading each array in PHP and confirming 162 entries
  with no key missing, added or empty, and by recomputing every trailing hash
  against the quote-escaped English source.

- **Six strings on the configuration page could not be translated at all.**
  Five had no key in any locale file, so no translation could ever reach them
  and they rendered in English in all nine languages — the step-4 line
  *"That's it: no developer account, no API keys, ever."*, the Do Not Track
  checkbox label, and three of the troubleshooting entries. The sixth, the
  answer about custom tweet colours, had only a bare-hash key, which
  PrestaShop 1.7+ never looks up.

  All five missing ones contain an apostrophe, which is the signature of the
  string exporter dropping them rather than of anything wrong in the template.
  The six keys are now present in all eight files with the
  `configure_<md5>` segment the template actually asks for, each hash
  confirmed against `md5(preg_replace("/\\*'/", "\'", $source))`.

  `l10n_template_coverage.py` now reports **all 77 template strings have a
  reachable key**, up from 71.

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
