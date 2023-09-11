{*
*	Module Name: Twitter Timeline Slider
*	Module URI: Please contact with info@megventure.com
*	Description: Use this module to display your twitter timeline sliding on your online store
*	Version: 3.2.0
*	Author: MEG Venture
*
*	Copyright 2014, MEG Venture (info@megventure.com)
*
*	This program is not a free software: you can't redistribute it and/or modify
*	it. All rights reserved.
*
*
*	This copyright notice  and licence should be retained in all modules based on this framework.
*	This does not affect your rights to assert copyright over your own original work.
*}

<!--TWITTER TIMELINE BY megventure.com-->
{if Configuration::get('twittertimeline_position')=="bottom_left"}
{assign var='twitterprofile' value=Configuration::get('twittertimeline_username')}
<link rel="stylesheet" type="text/css" href="{$module_dir|escape:'htmlall':'UTF-8'}views/css/bottom-left.css"/>
<div class="btn-floating">
<button
  type="button"
  id="modalbutton"
      class="btn btn-secondary collapsed float"
      data-toggle="collapse"
      data-target=".btn-floating-container"
>
<img src="{$module_dir}views/img/twitter-bird-light.png" width="35" alt="twitter bird" />
</button>
<div class="btn-floating-container collapse">
   <div class="btn-floating-menu">
     <a class="btn btn-floating-item" href="#" data-toggle="modal" data-target="#twittermodal"
       ><i class="material-icons">notifications_active</i>&nbsp;{l s='Latest news on social' mod='twittertimeline'}</a
     >
	</div>
</div>
</div>

<!-- Modal -->
<div
  class="modal fade"
  id="twittermodal"
  tabindex="-1"
  role="dialog"
  aria-labelledby="twittermodalLabel"
  aria-hidden="true"
>
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="twittermodalLabel"><img src="{$module_dir}views/img/twitter-bird-light.png" width="25" alt="twitter bird" />&nbsp;{l s='Latest Posts from Twitter' mod='twittertimeline'}</h5>
				<button
					type="button"
					class="close twitter_close"
					data-dismiss="modal"
					aria-label="Close"
					>
					<span aria-hidden="true">&times;</span>
				</button>
			</div> {* modal-header div *}
				<div class="modal-body">
					<div id="twitter_wrapper">
						<a class="twitter-timeline" href="https://twitter.com/{$twitterprofile}?ref_src=twsrc%5Etfw">{l s='Tweets by' mod='twittertimeline'} {$twitterprofile}</a>
							<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>							
					</div>
				</div> {* modal-body div *}
				<div class="modal-footer">
					<button
					type="button"
					class="btn btn-outline-secondary"
					data-dismiss="modal"
					>
					{l s='Close' mod='twittertimeline'}
					</button>
				</div> {* modal-footer div *}
		</div> {* modal-content div *}
	</div>  {* modal-dialog div *}
</div> {* callreuestmodal div*}
<!--TWITTER TIMELINE BY megventure.com-->
{/if}