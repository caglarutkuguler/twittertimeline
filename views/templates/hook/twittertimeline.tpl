{*
*	Module Name: Twitter and X Feed Widget
*	Description: Show your live Twitter/X timeline, or a single featured tweet, anywhere on your store.
*	Version: 4.1.1
*	Author: MEG Venture
*
*	Copyright 2007-2026, MEG Venture (info@megventure.com)
*
*	This program is not a free software: you can't redistribute it and/or modify
*	it. All rights reserved.
*}

<div class="twittertimeline-trigger twittertimeline-trigger--{$twittertimeline_position}">
{if $twittertimeline_position == 'floating'}
	<button type="button" class="twittertimeline-floating__toggle twittertimeline-open" data-toggle="modal" data-target="#twittertimeline-modal" aria-label="{if $twittertimeline_embed_type == 'tweet'}{l s='Featured post on Twitter/X' mod='twittertimeline'}{else}{l s='Latest posts on Twitter/X' mod='twittertimeline'}{/if}">
		<svg viewBox="0 0 24 24" width="26" height="26" fill="currentColor" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
	</button>
{else}
	<button type="button" class="twittertimeline-cta twittertimeline-open" data-toggle="modal" data-target="#twittertimeline-modal">
		<svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
		<span>{if $twittertimeline_embed_type == 'tweet'}{l s='See this post on Twitter/X' mod='twittertimeline'}{else}{l s='See our latest posts on Twitter/X' mod='twittertimeline'}{/if}</span>
	</button>
{/if}
</div>

<div class="modal fade" id="twittertimeline-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{if $twittertimeline_embed_type == 'tweet'}{l s='Featured post' mod='twittertimeline'}{else}{l s='Latest from' mod='twittertimeline'} @{$twittertimeline_username|escape:'html':'UTF-8'}{/if}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="{l s='Close' mod='twittertimeline'}"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body twittertimeline-modal__body">
				<div class="twittertimeline-embed"
					data-embed-type="{$twittertimeline_embed_type}"
					data-username="{$twittertimeline_username|escape:'html':'UTF-8'}"
					data-tweet-id="{$twittertimeline_tweet_id|escape:'html':'UTF-8'}"
					data-theme="{$twittertimeline_theme}"
					{if $twittertimeline_display_mode == 'fixed'}data-tweet-limit="{$twittertimeline_tweet_limit}"{else}data-height="{$twittertimeline_height}"{/if}
					{if $twittertimeline_link_color}data-link-color="{$twittertimeline_link_color}"{/if}
					{if $twittertimeline_chrome_attr}data-chrome="{$twittertimeline_chrome_attr}"{/if}
					data-dnt="{if $twittertimeline_dnt}true{else}false{/if}"
					data-lang="{$twittertimeline_widget_lang}"
					{if $twittertimeline_tweet_hide_conversation}data-hide-conversation="1"{/if}
					{if $twittertimeline_tweet_hide_media}data-hide-media="1"{/if}>
				</div>
				<p class="twittertimeline-fallback" style="display:none;">
					{l s='The live feed could not be loaded right now (Twitter/X is temporarily unavailable or rate-limiting embeds).' mod='twittertimeline'}<br>
					<a href="{if $twittertimeline_embed_type == 'tweet'}https://twitter.com/i/status/{$twittertimeline_tweet_id|escape:'html':'UTF-8'}{else}https://twitter.com/{$twittertimeline_username|escape:'html':'UTF-8'}{/if}" target="_blank" rel="noopener">{if $twittertimeline_embed_type == 'tweet'}{l s='View this tweet directly on Twitter/X' mod='twittertimeline'}{else}{l s='View this profile directly on Twitter/X' mod='twittertimeline'}{/if} &#8599;</a>
				</p>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	function twittertimelineLoadWidgetsJs(callback) {
		if (window.twttr && window.twttr.widgets) {
			callback(window.twttr);
			return;
		}
		window.twttr = (function (d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0], t = window.twttr || {};
			if (d.getElementById(id)) {
				return t;
			}
			js = d.createElement(s);
			js.id = id;
			js.src = 'https://platform.twitter.com/widgets.js';
			fjs.parentNode.insertBefore(js, fjs);
			t._e = [];
			t.ready = function (f) {
				t._e.push(f);
			};
			return t;
		}(document, 'script', 'twitter-wjs'));
		window.twttr.ready(callback);
	}

	function twittertimelineBuildEmbed(container) {
		var isTweet = container.getAttribute('data-embed-type') === 'tweet';

		if (isTweet) {
			var blockquote = document.createElement('blockquote');
			blockquote.className = 'twitter-tweet';
			['theme', 'link-color', 'dnt', 'lang'].forEach(function (attr) {
				var value = container.getAttribute('data-' + attr);
				if (value) {
					blockquote.setAttribute('data-' + attr, value);
				}
			});
			if (container.getAttribute('data-hide-conversation')) {
				blockquote.setAttribute('data-conversation', 'none');
			}
			if (container.getAttribute('data-hide-media')) {
				blockquote.setAttribute('data-cards', 'hidden');
			}
			var tweetAnchor = document.createElement('a');
			tweetAnchor.href = 'https://twitter.com/i/status/' + container.getAttribute('data-tweet-id');
			blockquote.appendChild(tweetAnchor);
			return blockquote;
		}

		var anchor = document.createElement('a');
		anchor.className = 'twitter-timeline';
		anchor.href = 'https://twitter.com/' + container.getAttribute('data-username') + '?ref_src=twsrc%5Etfw';
		anchor.textContent = 'Tweets by @' + container.getAttribute('data-username');
		['theme', 'tweet-limit', 'height', 'link-color', 'chrome', 'dnt', 'lang'].forEach(function (attr) {
			var value = container.getAttribute('data-' + attr);
			if (value) {
				anchor.setAttribute('data-' + attr, value);
			}
		});
		return anchor;
	}

	function twittertimelineOpen() {
		var modal = document.getElementById('twittertimeline-modal');
		var container = modal ? modal.querySelector('.twittertimeline-embed') : null;
		var fallback = modal ? modal.querySelector('.twittertimeline-fallback') : null;
		if (!container || container.querySelector('iframe')) {
			return;
		}

		container.innerHTML = '';
		container.style.display = '';
		if (fallback) {
			fallback.style.display = 'none';
		}

		var embedEl = twittertimelineBuildEmbed(container);
		container.appendChild(embedEl);

		var rendered = false;

		twittertimelineLoadWidgetsJs(function (twttr) {
			if (twttr.events && twttr.events.bind) {
				twttr.events.bind('rendered', function () {
					rendered = true;
				});
			}
			twttr.widgets.load(container);
		});

		setTimeout(function () {
			if (!rendered) {
				container.innerHTML = '';
				container.style.display = 'none';
				if (fallback) {
					fallback.style.display = '';
				}
			}
		}, 8000);
	}

	document.addEventListener('click', function (event) {
		var trigger = event.target.closest ? event.target.closest('.twittertimeline-open') : null;
		if (trigger) {
			twittertimelineOpen();
		}
	});
</script>
