{*
*	Module Name: Twitter & X Feed Widget
*	Description: Show your live Twitter/X timeline anywhere on your store.
*	Version: 4.0.1
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
				<a class="twitter-timeline"
					data-theme="{$twittertimeline_theme}"
					{if $twittertimeline_display_mode == 'fixed'}data-tweet-limit="{$twittertimeline_tweet_limit}"{else}data-height="{$twittertimeline_height}"{/if}
					{if $twittertimeline_link_color}data-link-color="{$twittertimeline_link_color}"{/if}
					{if $twittertimeline_chrome_attr}data-chrome="{$twittertimeline_chrome_attr}"{/if}
					data-dnt="{if $twittertimeline_dnt}true{else}false{/if}"
					data-lang="{$twittertimeline_widget_lang}"
					href="https://twitter.com/{$twittertimeline_username|escape:'html':'UTF-8'}?ref_src=twsrc%5Etfw">
					{l s='Tweets by' mod='twittertimeline'} @{$twittertimeline_username|escape:'html':'UTF-8'}
				</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	if (typeof jQuery !== 'undefined') {
		jQuery(document).on('shown.bs.modal', '#twittertimeline-modal', function () {
			var modal = this;
			if (window.twttr && window.twttr.ready) {
				window.twttr.ready(function (twttr) {
					twttr.widgets.load(modal);
				});
			}
		});
	}
</script>
