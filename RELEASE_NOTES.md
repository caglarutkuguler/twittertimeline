# Twitter and X Feed Widget — Release notes

_Only customer-relevant changes are listed. Internal refactoring, tests and housekeeping are omitted._

## 4.2.2

### Fixed
- The reason this lasted is worth recording: a locale file's keys are what the usual checks compare, and the keys were perfect. Nothing about a file full of English is structurally wrong, so file-exists, name, key-count and hash checks all pass. Only reading the values finds it
- All 156 are now translated in all seven languages. The module's own copy — configuration page, validation messages, troubleshooting answers, and the storefront button and popup — now renders in the merchant's and shopper's language
- Six strings on the configuration page could not be translated at all. Five had no key in any locale file, so no translation could ever reach them and they rendered in English in all nine languages — the step-4 line "That's it: no developer account, no API keys, ever.", the Do Not Track checkbox label, and three of the troubleshooting entries. The sixth, the answer about custom tweet colours, had only a bare-hash key, which PrestaShop 1.7+ never looks up
- `l10n_template_coverage.py` now reports all 77 template strings have a reachable key, up from 71

## 4.2.1

### Fixed
- The back-office icons turned into empty boxes on PrestaShop 9. The 9 icons the module draws for itself came from FontAwesome 4, which the back office shipped up to PrestaShop 8. PrestaShop 9 replaced it with Material Symbols Outlined, and FontAwesome now reaches the page only through `themes/default/public/theme.css` — a leftover of the old theme rather than anything the new back office asks for

## 4.2.0

### New
- A single review-request line on the module's own configuration page. It appears at the earliest 21 days after installing, asks once for a short review on megventure.com, and disappears forever after a click, a "No thanks", or three unanswered views. It makes no outbound request of any kind and stores nothing beyond three prefixed configuration values, which uninstalling removes
