{*
*	Module Name: Twitter Timeline Slider
*	Module URI: Please contact with info@megventure.com
*	Description: Use this module to display your twitter timeline sliding on your online store
*	Version: 3.1.0
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

{* <script type="text/javascript" src="{$ps_base_uri}js/jquery/jquery-colorpicker.js"></script> *}
<div class="panel">
	<h3><i class="icon icon-tags"></i> {l s='Documentation' mod='twittertimeline'}</h3>
	<p>
		{l s='Thanks for using Twitter Timeline Slider Module designed by MEG Venture. Please fill out all the fields below to function the module properly.' mod='twittertimeline'}
	</p>
	<p>
		&raquo; {l s='You can get a PDF documentation to configure this module' mod='twittertimeline'} :
		<ul>
			<li><a href="../modules/twittertimeline/readme_en.pdf" target="_blank">{l s='Documentation in English' mod='twittertimeline'}</a></li>
		</ul>
	</p>
</div>

<form name="configuration_form" action="{$action_uri}" method="post">
<div class="panel">
	<h3><i class="icon icon-credit-card"></i> {l s='Basic Settings' mod='twittertimeline'}</h3>
		<label>{l s='Twitter Username' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="text" name="usernameA" value="{$username}"/>
			<p class="clear">{l s='username is your twitter handle, without the @ symbol. Ex: Megventure' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Twitter Consumer Key' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="text" name="consumerkeyA" value="{$consumerkey}"/>
			<p class="clear">{l s='Consumer key. Ex: Megventure' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Twitter Consumer Secret' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="text" name="consumersecretA" value="{$consumersecret}"/>
			<p class="clear">{l s='Consumer secret. Ex: Megventure' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Twitter Access Token' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="text" name="accesstokenA" value="{$accesstoken}"/>
			<p class="clear">{l s='Access Token. Ex: Megventure' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Twitter Access Token Secret' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="text" name="accesstokensecretA" value="{$accesstokensecre}"/>
			<p class="clear">{l s='Access Token Secret. Ex: Megventure' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Twitter Timeline Slider Height' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="text" name="heightA" value="{$height}"/>
			<p class="clear">{l s='height of the twitter timeline in pixels. Ex: 105 for footer display, 340 for column display, 200 px for home page center column display' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Twitter Slider Time Interval' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="text" name="transitionspeedA" value="{$transitionspeed}"/>
			<p class="clear">{l s='transition speed in seconds. Tweets are displayed a sthe time interval determined. Ex: 5000 for 5 seconds' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Fading Effect Speed' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="radio" name="fadingeffectA" value="1500" {if $fadingeffect == "1500"}checked{/if}/>&nbsp;{l s='Slow' mod='twittertimeline'}&nbsp;&nbsp;
			<input type="radio" name="fadingeffectA" value="1000" {if $fadingeffect == "1000"}checked{/if}/>&nbsp;{l s='Medium' mod='twittertimeline'}&nbsp;&nbsp;
			<input type="radio" name="fadingeffectA" value="500" {if $fadingeffect == "500"}checked{/if}/>&nbsp;{l s='Fast' mod='twittertimeline'}
			<p class="clear">{l s='fading effect speed of the timeline' mod='twittertimeline'}</p>
		</div>
		<div class="row margin-form">
			<div class="col-md-12">
				<label>{l s='Tweet Limit' mod='twittertimeline'}</label>
				<select name="tweetlimitA" data-toggle="select2">
					<option value="" {if $tweetlimit == ""}selected{/if}>0</option>
					<option value="2" {if $tweetlimit == "2"}selected{/if}>2</option>
					<option value="4" {if $tweetlimit == "4"}selected{/if}>4</option>
					<option value="6" {if $tweetlimit == "6"}selected{/if}>6</option>
					<option value="8" {if $tweetlimit == "8"}selected{/if}>8</option>
					<option value="10" {if $tweetlimit == "10"}selected{/if}>10</option>
					<option value="12" {if $tweetlimit == "12"}selected{/if}>12</option>
					<option value="14" {if $tweetlimit == "14"}selected{/if}>14</option>
					<option value="16" {if $tweetlimit == "16"}selected{/if}>16</option>
					<option value="18" {if $tweetlimit == "18"}selected{/if}>18</option>
					<option value="20" {if $tweetlimit == "20"}selected{/if}>20</option>
					<option value="22" {if $tweetlimit == "22"}selected{/if}>22</option>
					<option value="24" {if $tweetlimit == "24"}selected{/if}>24</option>
					<option value="26" {if $tweetlimit == "26"}selected{/if}>26</option>
					<option value="28" {if $tweetlimit == "28"}selected{/if}>28</option>
					<option value="30" {if $tweetlimit == "30"}selected{/if}>30</option>
				</select>
			</div>
			<p class="clear">{l s='number of tweets to be listed in the timeline. To fix the size of a timeline to a preset number of Tweets.' mod='twittertimeline'}</p>
		</div>
		<div class="row margin-form">
			<div class="col-md-12">
				<label>{l s='Start from tweet order number' mod='twittertimeline'}</label>
				<select name="startfromA" data-toggle="select2">
					<option value="1" {if $startfrom == "1"}selected{/if}>1</option>
					<option value="2" {if $startfrom == "2"}selected{/if}>2</option>
					<option value="3" {if $startfrom == "3"}selected{/if}>3</option>
					<option value="4" {if $startfrom == "4"}selected{/if}>4</option>
					<option value="5" {if $startfrom == "5"}selected{/if}>5</option>
					<option value="6" {if $startfrom == "6"}selected{/if}>6</option>
					<option value="7" {if $startfrom == "7"}selected{/if}>7</option>
					<option value="8" {if $startfrom == "8"}selected{/if}>8</option>
					<option value="9" {if $startfrom == "9"}selected{/if}>9</option>
					<option value="10" {if $startfrom == "10"}selected{/if}>10</option>
					<option value="11" {if $startfrom == "11"}selected{/if}>11</option>
					<option value="12" {if $startfrom == "12"}selected{/if}>12</option>
					<option value="13" {if $startfrom == "13"}selected{/if}>13</option>
					<option value="14" {if $startfrom == "14"}selected{/if}>14</option>
					<option value="15" {if $startfrom == "15"}selected{/if}>15</option>
					<option value="16" {if $startfrom == "16"}selected{/if}>16</option>
					<option value="17" {if $startfrom == "17"}selected{/if}>17</option>
					<option value="18" {if $startfrom == "18"}selected{/if}>18</option>
					<option value="19" {if $startfrom == "19"}selected{/if}>19</option>
					<option value="20" {if $startfrom == "20"}selected{/if}>20</option>
					<option value="21" {if $startfrom == "21"}selected{/if}>21</option>
					<option value="22" {if $startfrom == "22"}selected{/if}>22</option>
					<option value="23" {if $startfrom == "23"}selected{/if}>23</option>
					<option value="24" {if $startfrom == "24"}selected{/if}>24</option>
					<option value="25" {if $startfrom == "25"}selected{/if}>25</option>
					<option value="26" {if $startfrom == "26"}selected{/if}>26</option>
					<option value="27" {if $startfrom == "27"}selected{/if}>27</option>
					<option value="28" {if $startfrom == "28"}selected{/if}>28</option>
					<option value="29" {if $startfrom == "29"}selected{/if}>29</option>
					<option value="30" {if $startfrom == "30"}selected{/if}>30</option>
				</select>
			</div>
			<p class="clear">{l s='slider will start from the tweet number stated when we order the available tweets from the new to the old.' mod='twittertimeline'}</p>
		</div>
</div>

<div class="panel">
	<h3><i class="icon icon-credit-card"></i> {l s='Options' mod='twittertimeline'}</h3>
		<label>{l s='Position of the widget' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="radio" name="positionA" value="left" {if $position == "left"}checked{/if}/>&nbsp;{l s='Left' mod='twittertimeline'}&nbsp;&nbsp;
			<input type="radio" name="positionA" value="right" {if $position == "right"}checked{/if}/>&nbsp;{l s='Right' mod='twittertimeline'}&nbsp;&nbsp;
			<input type="radio" name="positionA" value="footer" {if $position == "footer"}checked{/if}/>&nbsp;{l s='Footer' mod='twittertimeline'}&nbsp;&nbsp;
			<input type="radio" name="positionA" value="home" {if $position == "home"}checked{/if}/>&nbsp;{l s='Homepage' mod='twittertimeline'}
			<input type="radio" name="positionA" value="bottom_left" {if $position == "bottom_left"}checked{/if}/>&nbsp;{l s='Bottom-left button' mod='twittertimeline'}
			<p class="clear">{l s='determine the position of the widget' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Tweet text color' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input width="20px" type="color" data-hex="true" class="color mColorPickerInput" name="textcolorA" value="{$textcolor}"/>
			<p class="clear">{l s='tweet text color of the twitter timeline widget.' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Tweet links color' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input width="20px" type="color" data-hex="true" class="color mColorPickerInput" name="linkcolorA" value="{$linkcolor}"/>
			<p class="clear">{l s='color of the tweet links. Note that some icons in the widget will also appear this color.' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Tweeter bird color' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input width="20px" type="color" data-hex="true" class="color mColorPickerInput" name="birdcolorA" value="{$birdcolor}"/>
			<p class="clear">{l s='this is the bird icon on the twitter widget. Valid only for the footer position.' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Show retweets' mod='twittertimeline'}</label>
		<div class="margin-form">
			<img src="{$ps_base_uri}img/admin/enabled.gif" /><input type="radio" name="showretweetA" value="true" {if $showretweet == "true"}checked{/if}/>&nbsp;{l s='Yes' mod='twittertimeline'}&nbsp;&nbsp;
			<img src="{$ps_base_uri}img/admin/disabled.gif" /><input type="radio" name="showretweetA" value="false" {if $showretweet == "false"}checked{/if}/>&nbsp;{l s='No' mod='twittertimeline'}
			<p class="clear">{l s='shows retweets if enabled' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Show tweet links' mod='twittertimeline'}</label>
		<div class="margin-form">
			<img src="{$ps_base_uri}img/admin/enabled.gif" /><input type="radio" name="showtweetlinkA" value="true" {if $showtweetlink == "true"}checked{/if}/>&nbsp;{l s='Yes' mod='twittertimeline'}&nbsp;&nbsp;
			<img src="{$ps_base_uri}img/admin/disabled.gif" /><input type="radio" name="showtweetlinkA" value="false" {if $showtweetlink == "false"}checked{/if}/>&nbsp;{l s='No' mod='twittertimeline'}
			<p class="clear">{l s='tweet links are displayed as functional links if enabled' mod='twittertimeline'}</p>
		</div>
		<label>{l s='Additional Options' mod='twittertimeline'}</label>
		<div class="margin-form">
			<input type="checkbox" name="profilepicA" value="true" {if $showtweetlink == "true"}checked="checked"{/if}>&nbsp;{l s='Display profile picture' mod='twittertimeline'}<br>
			<p class="clear">{l s='displays profile picture next to the retweets if enabled.' mod='twittertimeline'}</p>
			<input type="checkbox" name="tweetactionA" value="true" {if $tweetaction == "true"}checked="checked"{/if}>&nbsp;{l s='Display tweet actions' mod='twittertimeline'}<br>
			<p class="clear">{l s='displays tweet actions of reply, retweet, favorite if enabled.' mod='twittertimeline'}</p>
			<input type="checkbox" name="retweetindicatorA" value="true" {if $retweetindicator == "true"}checked="checked"{/if}>&nbsp;{l s='Display retweet indicator on the bottom left if the tweet is a RT' mod='twittertimeline'}<br>
			<p class="clear">{l s='displays retweet indicator if enabled.' mod='twittertimeline'}</p>
			<input type="checkbox" name="displayheaderA" value="true" {if $displayheader == "true"}checked="checked"{/if}>&nbsp;{l s='Display header' mod='twittertimeline'}<br>
			<p class="clear">{l s='displays the header contaning the username if enabled.' mod='twittertimeline'}</p>
			<input type="checkbox" name="directtweetA" value="true" {if $directtweet == "true"}checked="checked"{/if}>&nbsp;{l s='Display direct tweets' mod='twittertimeline'}<br>
			<p class="clear">{l s='displays the direct tweets starting with @ sign.' mod='twittertimeline'}</p>
		</div>
</div>

<div class="panel-footer" style="margin-bottom:70px;margin-right:5px;padding-bottom: 70px;">
    <button type="submit" value="1" id="module_form_submit_btn_1" name="submit" class="btn btn-default pull-right">
        <i class="process-icon-save"></i> {l s='Save' mod='twittertimeline'}
    </button>
</div>
</form>
