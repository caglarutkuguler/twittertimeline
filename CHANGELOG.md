# Changelog

All notable changes to **Twitter and X Feed Widget** (`twittertimeline`).

## 4.1.1

### Fixed

- **Upgrade could disable the module on some shops.** The 4.0.1 upgrade
  step's success hinged directly on a `registerHook()` call returning true;
  a transient failure there (or the hook already being registered from a
  partial prior attempt) marked the whole upgrade step failed and
  PrestaShop disabled the module. The hook is now registered idempotently
  and the step always reports success.
