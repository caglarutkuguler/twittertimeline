# Changelog

All notable changes to **Twitter and X Feed Widget** (`twittertimeline`).

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
