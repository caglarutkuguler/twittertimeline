{*
*	Module Name: Twitter & X Feed Widget
*	Module URI: Please contact info@megventure.com
*	Description: Show your live Twitter/X timeline anywhere on your store. No API keys, no developer account, just your username.
*	Version: 4.0.2
*	Author: MEG Venture
*
*	Copyright 2007-2026, MEG Venture (info@megventure.com)
*
*	This program is not a free software: you can't redistribute it and/or modify
*	it. All rights reserved.
*
*
*	This copyright notice  and licence should be retained in all modules based on this framework.
*	This does not affect your rights to assert copyright over your own original work.
*}

<link rel="stylesheet" href="{$twittertimeline_module_dir}views/css/twittertimeline.css">

<div class="panel twittertimeline-intro">
	<div class="panel-heading">
		<i class="icon icon-twitter"></i> {l s='Twitter & X Feed Widget' mod='twittertimeline'}
	</div>
	<p>{l s='Show your live Twitter/X timeline anywhere on your store. This module embeds the official Twitter/X widget, so there are no API keys to manage, no developer account to create, and nothing that can break when Twitter/X changes its API.' mod='twittertimeline'}</p>
</div>

{if !$twittertimeline_hide_tutorial}
<div class="panel">
	<div class="panel-heading">
		<i class="icon icon-graduation-cap"></i> {l s='Quick start' mod='twittertimeline'}
	</div>
	<ol class="twittertimeline-steps">
		<li><strong>{l s='Enter your Twitter/X username' mod='twittertimeline'}</strong> {l s='below, without the @ symbol.' mod='twittertimeline'}</li>
		<li><strong>{l s='Choose where the button should appear' mod='twittertimeline'}</strong> {l s='on your store: left column, right column, footer, home page, or a floating button. Every option opens the same popup with your live feed when clicked.' mod='twittertimeline'}</li>
		<li><strong>{l s='Customize the look' mod='twittertimeline'}</strong> {l s='(theme, colors, size) to match your store.' mod='twittertimeline'}</li>
		<li><strong>{l s='Save.' mod='twittertimeline'}</strong> {l s="That's it: no developer account, no API keys, ever." mod='twittertimeline'}</li>
	</ol>
	<form action="{$twittertimeline_action_uri}" method="post">
		<button type="submit" name="submitTwitterTimelineTutorial" class="btn btn-default">
			<i class="icon icon-eye-slash"></i> {l s='Got it, hide this' mod='twittertimeline'}
		</button>
	</form>
</div>
{/if}

{if $twittertimeline_username}
<div class="panel">
	<div class="panel-heading">
		<i class="icon icon-eye"></i> {l s='Live preview' mod='twittertimeline'}
	</div>
	<p class="twittertimeline-hint">{l s='This is exactly what visitors will see and click on your store, based on your last saved settings. Save the form below to update it.' mod='twittertimeline'}</p>
	<div class="twittertimeline-preview-frame">
		{include file="module:twittertimeline/views/templates/hook/twittertimeline.tpl"}
	</div>
</div>
{/if}

<form action="{$twittertimeline_action_uri}" method="post" class="form-horizontal twittertimeline-form">
<div class="panel">
	<div class="panel-heading">
		<i class="icon icon-user"></i> {l s='Account' mod='twittertimeline'}
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3">{l s='Twitter/X username' mod='twittertimeline'}</label>
		<div class="col-lg-9">
			<div class="input-group fixed-width-lg">
				<span class="input-group-addon">@</span>
				<input type="text" class="form-control" name="TWITTERTIMELINE_USERNAME" value="{$twittertimeline_username}" placeholder="{l s='e.g. megventure' mod='twittertimeline'}" maxlength="15" />
			</div>
			<p class="help-block">{l s='Your public Twitter/X handle, without the @ symbol. No password, API key, or developer account required.' mod='twittertimeline'}</p>
		</div>
	</div>
</div>

<div class="panel">
	<div class="panel-heading">
		<i class="icon icon-map-marker"></i> {l s='Placement' mod='twittertimeline'}
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3">{l s='Where should the button appear?' mod='twittertimeline'}</label>
		<div class="col-lg-9">
			<select name="TWITTERTIMELINE_POSITION" class="form-control fixed-width-lg">
				<option value="left" {if $twittertimeline_position == 'left'}selected{/if}>{l s='Left column' mod='twittertimeline'}</option>
				<option value="right" {if $twittertimeline_position == 'right'}selected{/if}>{l s='Right column' mod='twittertimeline'}</option>
				<option value="footer" {if $twittertimeline_position == 'footer'}selected{/if}>{l s='Footer' mod='twittertimeline'}</option>
				<option value="home" {if $twittertimeline_position == 'home'}selected{/if}>{l s='Home page' mod='twittertimeline'}</option>
				<option value="floating" {if $twittertimeline_position == 'floating'}selected{/if}>{l s='Floating button (fixed, bottom-left corner)' mod='twittertimeline'}</option>
			</select>
			<p class="help-block">{l s='In every case, a small button appears at this location; clicking it opens your live feed in a popup. Not every theme supports every column position, if nothing appears after saving, try Footer, it works with virtually every theme.' mod='twittertimeline'}</p>
		</div>
	</div>
</div>

<div class="panel">
	<div class="panel-heading">
		<i class="icon icon-paint-brush"></i> {l s='Appearance' mod='twittertimeline'}
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3">{l s='Number of tweets' mod='twittertimeline'}</label>
		<div class="col-lg-9">
			<label class="radio-inline">
				<input type="radio" name="TWITTERTIMELINE_DISPLAY_MODE" value="fixed" id="twittertimeline-mode-fixed" {if $twittertimeline_display_mode == 'fixed'}checked{/if} />
				{l s='Show a fixed number of tweets' mod='twittertimeline'}
			</label>
			<label class="radio-inline">
				<input type="radio" name="TWITTERTIMELINE_DISPLAY_MODE" value="scroll" id="twittertimeline-mode-scroll" {if $twittertimeline_display_mode == 'scroll'}checked{/if} />
				{l s='Continuous scrolling feed' mod='twittertimeline'}
			</label>
			<div id="twittertimeline-field-tweet-limit" class="twittertimeline-subfield">
				<input type="number" class="form-control fixed-width-sm" name="TWITTERTIMELINE_TWEET_LIMIT" min="1" max="20" value="{$twittertimeline_tweet_limit}" />
				<p class="help-block">{l s='1 to 20 tweets (this is a hard limit set by the Twitter/X widget).' mod='twittertimeline'}</p>
			</div>
			<div id="twittertimeline-field-height" class="twittertimeline-subfield">
				<input type="number" class="form-control fixed-width-sm" name="TWITTERTIMELINE_HEIGHT" min="200" max="1200" value="{$twittertimeline_height}" /> px
				<p class="help-block">{l s='Height of the scrolling feed, between 200 and 1200 pixels.' mod='twittertimeline'}</p>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3">{l s='Theme' mod='twittertimeline'}</label>
		<div class="col-lg-9">
			<label class="radio-inline">
				<input type="radio" name="TWITTERTIMELINE_THEME" value="light" {if $twittertimeline_theme == 'light'}checked{/if} /> {l s='Light' mod='twittertimeline'}
			</label>
			<label class="radio-inline">
				<input type="radio" name="TWITTERTIMELINE_THEME" value="dark" {if $twittertimeline_theme == 'dark'}checked{/if} /> {l s='Dark' mod='twittertimeline'}
			</label>
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3">{l s='Accent color' mod='twittertimeline'}</label>
		<div class="col-lg-9">
			<input type="text" class="form-control fixed-width-sm" name="TWITTERTIMELINE_LINK_COLOR" value="{$twittertimeline_link_color}" placeholder="#1DA1F2" />
			<p class="help-block">{l s='Optional. Hex color used for links inside the widget, e.g. #1DA1F2. Leave empty to use the default.' mod='twittertimeline'}</p>
		</div>
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3">{l s='Advanced' mod='twittertimeline'}</label>
		<div class="col-lg-9">
			<label class="checkbox-inline">
				<input type="checkbox" name="TWITTERTIMELINE_CHROME_NOHEADER" value="1" {if $twittertimeline_chrome_noheader}checked{/if} /> {l s='Hide header' mod='twittertimeline'}
			</label>
			<label class="checkbox-inline">
				<input type="checkbox" name="TWITTERTIMELINE_CHROME_NOFOOTER" value="1" {if $twittertimeline_chrome_nofooter}checked{/if} /> {l s='Hide footer' mod='twittertimeline'}
			</label>
			<label class="checkbox-inline">
				<input type="checkbox" name="TWITTERTIMELINE_CHROME_NOBORDERS" value="1" {if $twittertimeline_chrome_noborders}checked{/if} /> {l s='Hide borders' mod='twittertimeline'}
			</label>
			<label class="checkbox-inline">
				<input type="checkbox" name="TWITTERTIMELINE_CHROME_TRANSPARENT" value="1" {if $twittertimeline_chrome_transparent}checked{/if} /> {l s='Transparent background' mod='twittertimeline'}
			</label>
		</div>
	</div>
</div>

<div class="panel">
	<div class="panel-heading">
		<i class="icon icon-shield"></i> {l s='Privacy' mod='twittertimeline'}
	</div>
	<div class="form-group">
		<label class="control-label col-lg-3">{l s='Do Not Track' mod='twittertimeline'}</label>
		<div class="col-lg-9">
			<label class="checkbox-inline">
				<input type="checkbox" name="TWITTERTIMELINE_DNT" value="1" {if $twittertimeline_dnt}checked{/if} /> {l s="Don't let Twitter/X personalize or track visitors through this widget" mod='twittertimeline'}
			</label>
			<p class="help-block">{l s='Recommended if you need to stay GDPR-friendly. This widget still loads a script from platform.twitter.com, mention it in your cookie/privacy policy.' mod='twittertimeline'}</p>
		</div>
	</div>
</div>

<div class="panel-footer">
	<button type="submit" name="submitTwitterTimeline" class="btn btn-default pull-right">
		<i class="process-icon-save"></i> {l s='Save' mod='twittertimeline'}
	</button>
</div>
</form>

<div class="panel">
	<div class="panel-heading">
		<i class="icon icon-question-circle"></i> {l s='Troubleshooting' mod='twittertimeline'}
	</div>
	<dl class="twittertimeline-faq">
		<dt>{l s="My feed isn't showing up" mod='twittertimeline'}</dt>
		<dd>{l s='Double-check your username for typos and make sure it has no @ symbol. Then confirm your theme actually displays the position you chose, try Footer, which almost every theme supports. Ad blockers and strict tracking blockers can also hide the widget for some visitors; this is expected and outside the module\'s control.' mod='twittertimeline'}</dd>
		<dt>{l s='The feed shows slightly outdated tweets' mod='twittertimeline'}</dt>
		<dd>{l s="That's normal: Twitter/X caches the embedded widget for a few minutes on their end. It catches up automatically." mod='twittertimeline'}</dd>
		<dt>{l s='The popup does not open, or opens empty' mod='twittertimeline'}</dt>
		<dd>{l s="The button relies on your theme's Bootstrap modal support. Most PrestaShop 1.7+ themes include this by default; a heavily customized theme may need it added back." mod='twittertimeline'}</dd>
		<dt>{l s='Can I use fully custom colors for tweet text?' mod='twittertimeline'}</dt>
		<dd>{l s="The official widget only supports a Light/Dark theme plus one accent color, by design from Twitter/X. This trade-off is what keeps the feed working reliably without API keys." mod='twittertimeline'}</dd>
	</dl>
</div>

<script type="text/javascript">
	(function () {
		function toggleTwitterTimelineFields() {
			var fixed = document.getElementById('twittertimeline-mode-fixed');
			var isFixed = fixed && fixed.checked;
			document.getElementById('twittertimeline-field-tweet-limit').style.display = isFixed ? '' : 'none';
			document.getElementById('twittertimeline-field-height').style.display = isFixed ? 'none' : '';
		}
		['twittertimeline-mode-fixed', 'twittertimeline-mode-scroll'].forEach(function (id) {
			var el = document.getElementById(id);
			if (el) {
				el.addEventListener('change', toggleTwitterTimelineFields);
			}
		});
		toggleTwitterTimelineFields();
	})();
</script>
