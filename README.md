# Twitter & X Feed Widget

Show your live Twitter/X timeline anywhere on your PrestaShop store: left column, right column, footer, home page, or a floating button. No API keys, no developer account, no OAuth setup. Just your username.

**Technical module name:** `twittertimeline` (unchanged from previous versions, so existing installs upgrade cleanly)
**Compatibility:** PrestaShop 1.7 and above (1.7, 8.x, 9.x)
**Version:** 4.0.0

## Why this rewrite

Earlier versions of this module fetched tweets through the Twitter API v1.1, using a bundled, decade-old OAuth library and hardcoded developer credentials. Twitter/X shut down free access to that API in 2023, and the shipped credentials had been publicly exposed in every copy of the module for years, so the old integration no longer worked reliably for anyone, and installing an old copy silently pulled someone else's Twitter feed by default.

Version 4.0.0 switches entirely to Twitter/X's own official embedded timeline widget. It is:

- **Instant to set up** - enter your username, no developer account or API keys.
- **Impossible to leak credentials for** - there are none to store.
- **Future-proof** - maintained directly by Twitter/X, not by an aging third-party library.
- **Fully interactive** - native reply, retweet, and like actions, exactly like on twitter.com/x.com.
- **Privacy-friendly** - an optional "Do Not Track" setting for GDPR-conscious stores.

## Quick start

1. Install and activate the module.
2. Go to **Modules > Twitter & X Feed Widget > Configure**.
3. Enter your Twitter/X username (no `@`).
4. Choose where it should appear.
5. Adjust appearance if you like, then **Save**.

That's the entire setup, no other step is required.

## Settings reference

| Setting | Description |
|---|---|
| Username | Your public Twitter/X handle, without `@`. |
| Placement | Left column, right column, footer, home page, or a floating button (bottom-left). |
| Display mode | A fixed number of tweets (1-20), or a continuously scrolling feed with a custom height. |
| Theme | Light or dark. |
| Accent color | Optional hex color for links inside the widget. |
| Advanced | Hide header / footer / borders, or make the background transparent. |
| Do Not Track | Ask Twitter/X not to personalize or track visitors through the widget. |

## Troubleshooting

**My feed isn't showing up.**
Check the username for typos and make sure it has no `@`. Then confirm your theme actually renders the position you picked, not every theme supports every column; Footer works almost everywhere. Ad blockers and strict tracking blockers may also hide the widget for some visitors, which is expected.

**The feed shows tweets that are a few minutes old.**
Normal - Twitter/X caches the widget briefly on their end.

**The floating button doesn't open.**
It uses your theme's Bootstrap modal. The default PrestaShop 1.7+ classic theme supports this out of the box; a heavily customized theme might not.

**I want fully custom colors for tweet text, not just an accent color.**
The official widget only exposes a light/dark theme plus one accent color, that limitation comes from Twitter/X, not this module. It's the trade-off for a feed that needs no API keys and won't break again.

**I upgraded from an older version, where did my API keys go?**
They were removed on purpose during the upgrade, along with several other legacy settings that no longer apply. The old integration required Twitter API credentials (which, on unconfigured installs, defaulted to the developer's own since-leaked keys), the new one only needs your username.

## Privacy note

This module loads a script from `platform.twitter.com` on pages where the feed is displayed. Disclose this in your cookie/privacy policy as you would for any third-party embed. The optional "Do Not Track" setting asks Twitter/X not to personalize the experience, but it does not prevent the script from loading.

## Support

MEG Venture - info@megventure.com
