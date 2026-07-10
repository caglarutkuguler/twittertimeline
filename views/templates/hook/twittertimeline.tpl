{*
*	Module Name: Twitter and X Feed Widget
*	Description: Show your live Twitter/X timeline anywhere on your store.
*	Version: 4.0.3
*	Author: MEG Venture
*
*	Copyright 2007-2026, MEG Venture (info@megventure.com)
*
*	This program is not a free software: you can't redistribute it and/or modify
*	it. All rights reserved.
*}

<div class="twittertimeline-trigger twittertimeline-trigger--{$twittertimeline_position}">
{if $twittertimeline_position == 'floating'}
	<button type="button" class="twittertimeline-floating__toggle" data-toggle="modal" data-target="#twittertimeline-modal" aria-label="{l s='Latest posts on Twitter/X' mod='twittertimeline'}">
		<svg viewBox="0 0 24 24" width="26" height="26" fill="currentColor" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
	</button>
{else}
	<button type="button" class="twittertimeline-cta" data-toggle="modal" data-target="#twittertimeline-modal">
		<svg viewBox="0 0 24 24" width="18" height="18" fill="currentColor" aria-hidden="true"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
		<span>{l s='See our latest posts on Twitter/X' mod='twittertimeline'}</span>
	</button>
{/if}
</div>

<div class="modal fade" id="twittertimeline-modal" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">{l s='Latest from' mod='twittertimeline'} @{$twittertimeline_username|escape:'html':'UTF-8'}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="{l s='Close' mod='twittertimeline'}"><span aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body twittertimeline-modal__body">
				<div class="twittertimeline-embed"
					data-username="{$twittertimeline_username|escape:'html':'UTF-8'}"
					data-theme="{$twittertimeline_theme}"
					{if $twittertimeline_display_mode == 'fixed'}data-tweet-limit="{$twittertimeline_tweet_limit}"{else}data-height="{$twittertimeline_height}"{/if}
					{if $twittertimeline_link_color}data-link-color="{$twittertimeline_link_color}"{/if}
					{if $twittertimeline_chrome_attr}data-chrome="{$twittertimeline_chrome_attr}"{/if}
					data-dnt="{if $twittertimeline_dnt}true{else}false{/if}"
					data-lang="{$twittertimeline_widget_lang}">
				</div>
				<p class="twittertimeline-fallback" style="display:none;">
					{l s='The live feed could not be loaded right now (Twitter/X is temporarily unavailable or rate-limiting embeds).' mod='twittertimeline'}<br>
					<a href="https://twitter.com/{$twittertimeline_username|escape:'html':'UTF-8'}" target="_blank" rel="noopener">{l s='View this profile directly on Twitter/X' mod='twittertimeline'} &#8599;</a>
				</p>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	console.log('[TwitterTimeline] script tag parsed and executing');

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

	var TWITTERTIMELINE_DEBUG = true;
	function twittertimelineLog() {
		if (TWITTERTIMELINE_DEBUG && window.console && console.log) {
			var args = Array.prototype.slice.call(arguments);
			args.unshift('[TwitterTimeline]');
			console.log.apply(console, args);
		}
	}

	twittertimelineLog('template loaded, jQuery available:', typeof jQuery !== 'undefined');

	if (typeof jQuery !== 'undefined') {
		jQuery(document).on('shown.bs.modal', '#twittertimeline-modal', function () {
			twittertimelineLog('shown.bs.modal fired');
			var modal = this;
			var container = modal.querySelector('.twittertimeline-embed');
			var fallback = modal.querySelector('.twittertimeline-fallback');
			twittertimelineLog('container found:', !!container, 'already has iframe:', !!(container && container.querySelector('iframe')));
			if (!container || container.querySelector('iframe')) {
				return;
			}

			container.innerHTML = '';
			container.style.display = '';
			if (fallback) {
				fallback.style.display = 'none';
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
			container.appendChild(anchor);
			twittertimelineLog('anchor built and appended, requesting widgets.js', anchor.outerHTML);

			twittertimelineLoadWidgetsJs(function (twttr) {
				twittertimelineLog('widgets.js ready, calling twttr.widgets.load()');
				twttr.widgets.load(container);
			});

			setTimeout(function () {
				var loaded = !!container.querySelector('iframe');
				twittertimelineLog('8s timeout check, iframe present:', loaded);
				if (!loaded) {
					container.style.display = 'none';
					if (fallback) {
						fallback.style.display = '';
					}
				}
			}, 8000);
		});
	} else {
		twittertimelineLog('jQuery is not defined on this page, the popup trigger and feed loader cannot run.');
	}
</script>
