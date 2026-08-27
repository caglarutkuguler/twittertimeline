# Twitter and X Feed Widget

Show your live Twitter/X timeline, or a single featured tweet, anywhere on your PrestaShop store: left column, right column, footer, home page, or a floating button. No API keys, no developer account, no OAuth setup. Just your username, or a tweet link.

**Technical module name:** `twittertimeline` (unchanged from previous versions, so existing installs upgrade cleanly)
**Compatibility:** PrestaShop 1.7 and above (1.7, 8.x, 9.x)
**Version:** 4.2.0

**Installable zip:** the archive GitHub generates on the releases page is a source snapshot, not an installable module — PrestaShop rejects it because the folder inside carries the version number. Download the ready-to-install zip from [megventure.com](https://megventure.com/en/free-modules/33-prestashop-twitter-x-feed-widget-no-api-keys-8691246295736.html).

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
2. Go to **Modules > Twitter and X Feed Widget > Configure**.
3. Choose **Live timeline** (enter your Twitter/X username, no `@`) or **Featured tweet** (paste the link to one specific tweet).
4. Choose where it should appear.
5. Adjust appearance if you like, then **Save**.

That's the entire setup, no other step is required.

## Live timeline vs. Featured tweet

Both modes use Twitter/X's official embed widget and need no API keys. The difference:

- **Live timeline** shows a continuously updating stream of the account's latest posts. It has to fetch fresh data from Twitter/X's backend every time a visitor opens it.
- **Featured tweet** shows one specific post you choose. Because it only ever needs that one fixed tweet, it tends to hold up better when Twitter/X's embed backend is under heavy load or rate-limiting requests (see Troubleshooting below).

If you mainly want reliability over automatic updates, Featured tweet is the safer choice.

## Settings reference

| Setting | Description |
|---|---|
| What should it show? | Live timeline (auto-updating) or Featured tweet (a single post). |
| Username | Your public Twitter/X handle, without `@`. Used in Live timeline mode. |
| Tweet link | The full URL of the tweet to feature, e.g. `https://twitter.com/username/status/1234567890123456789`. Used in Featured tweet mode. |
| Placement | Left column, right column, footer, home page, or a floating button (bottom-left). |
| Display mode | (Live timeline only) A fixed number of tweets (1-20), or a continuously scrolling feed with a custom height. |
| Featured tweet options | (Featured tweet only) Hide the "Show this thread" link, hide photo/video/link previews. |
| Theme | Light or dark. |
| Accent color | Optional hex color for links inside the widget. |
| Advanced | (Live timeline only) Hide header / footer / borders, or make the background transparent. |
| Do Not Track | Ask Twitter/X not to personalize or track visitors through the widget. |

## Troubleshooting

**My feed isn't showing up.**
Check the username or tweet link for typos. Then confirm your theme actually renders the position you picked, not every theme supports every column; Footer works almost everywhere. Ad blockers and strict tracking blockers may also hide the widget for some visitors, which is expected.

**The popup opens but shows "The live feed could not be loaded right now."**
This means Twitter/X's own embed backend rejected or rate-limited the request when your browser asked it for the content, this is not something the module's code controls. It's a known, currently common issue: Twitter/X's public embed service enforces a fairly tight rate limit (around 30 requests per 15 minutes by default), and a single timeline load can use up most of that quota. It usually clears on its own after a few minutes. If it happens often on your store, switching to Featured tweet mode is more resilient, since it only ever requests one fixed post instead of a continuously refreshing feed.

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
