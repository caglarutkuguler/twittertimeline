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
{if Configuration::get('twittertimeline_position')=="home"}
<br />
<!--TWITTER TIMELINE BY megventure.com-->
<!--See the module's main file for license and credits-->
{assign var='linkcolor' value = Configuration::get('twittertimeline_linkcolor')}
{if Configuration::get('twittertimeline_displayheader')}{assign var='displayheader' value=Configuration::get('twittertimeline_displayheader')}{else}{assign var='displayheader' value='false'}{/if}

<style type="text/css">
/* CSS Document */

#loading-container {
    padding:16px 0px 16px 0px;
    text-align:center;  
}
 
#twitter-feed {
    margin:auto;
    font:normal normal normal 12px/16px "Helvetica Neue",showtweetlinkl,sans-serif;
    padding:8px 10px 12px 10px;
    border-radius:12px;
    background-color:#FFF;
    color:#333;
    overflow:auto;
}
 
#twitter-feed h1 {
    color:#5F5F5F;
    margin:0px;
    padding:9px 0px 9px 0px;
    font-size:10px;
    font-weight:lighter;    
	background:none !important; 	
}

#twitter-header {
	background-color:#FFF;
	position:relative;
	z-index:2;
	border-bottom:1px dotted #CCC;
	{if $displayheader == "false"}
	display:none;
	{else}
	{/if}	
}

.tweets-container {
	width:100%;
	overflow:hidden;
	position:relative;	
}
 
.twitter-article, #loading-container {
    width:100%;
    float:left; 
    padding:8px 0px 8px 0px;
	position:relative;
} 

.twitter-article {
	position:absolute;
	border-bottom:1px dotted #CCC;
	top:0px;
}

.twitter-pic {
    position:absolute;
}
 
.twitter-pic img {
    float:left;
    border-radius:7px;  
    border:none;
     
}
 
/* -------- TEXT STYLING ------*/
.twitter-text {
    width:100%;
    float:left;
    font-size:11px;
    padding-left:52px;
	-moz-box-sizing: border-box;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
}
.twitter-text p {
    margin:0px;
    line-height:15px;   
}
.twitter-text a,  h1 a {
    color: {$linkcolor} !important;
    text-decoration: none;
}
.twitter-text a:hover,  h1 a:hover {
    text-decoration: underline;
    color: {$linkcolor} !important;
}
 
.tweet-time {
    font-size:10px;
    color:#333;
    float:right;
	margin-right:5px;
}
.tweet-time a, .tweet-time a:hover {
    color:#878787;
}
 
.tweetprofilelink a {
    color:#444;
}
.tweetprofilelink a:hover {
    color:#444;
}
 
/* -------- FEED  ACTIONS ------*/
#twitter-actions {
    width:75px;
    float:right;
    margin-right:5px;   
        display:none;
    margin-top:-10px !important;
		
}
.intent {
    width:25px;
    height:16px;
    float:left; 
}
.intent a{
    width:25px;
    height:16px;
    display:block;
    background-image:url({$module_dir}views/img/tweet-actions.png);
    float:left; 
} 
.intent a:hover{
    background-position:-25px 0px;
} 
 
#intent-retweet a{
    background-position:0px -17px;
} 
#intent-retweet a:hover{
    background-position:-25px -17px;
} 
#intent-fave a{
    background-position:0px -36px;
} 
#intent-fave a:hover{
    background-position:-25px -36px;
} 
 
/* -------- RETWEET INDICATOR ------*/
#retweet-indicator {
    width:14px;
    height:10px;
    background-image:url({$module_dir}views/img/tweet-actions.png);
    background-position:-5px -54px;
    margin-top:3px;
    float:left;
}

</style>

{assign var='limit' value = Configuration::get('twittertimeline_tweetlimit')}
{assign var='twitterprofile' value=Configuration::get('twittertimeline_username')}
{assign var='fadingspeed' value=Configuration::get('twittertimeline_fadingeffect')}
{assign var='transitionspeed' value=Configuration::get('twittertimeline_transitionspeed')}
{assign var='showretweet' value=Configuration::get('twittertimeline_showretweet')}
{assign var='showtweetlink' value=Configuration::get('twittertimeline_showtweetlink')}
{assign var='startfrom' value=Configuration::get('twittertimeline_startfrom')}
{if Configuration::get('twittertimeline_profilepic')}{assign var='showprofilepic' value=Configuration::get('twittertimeline_profilepic')}{else}{assign var='showprofilepic' value='false'}{/if}
{if Configuration::get('twittertimeline_tweetaction')}{assign var='showtweetactions' value=Configuration::get('twittertimeline_tweetaction')}{else}{assign var='showtweetactions' value='false'}{/if}
{if Configuration::get('twittertimeline_retweetindicator')}{assign var='showretweetindicator' value=Configuration::get('twittertimeline_retweetindicator')}{else}{assign var='showretweetindicator' value='false'}{/if}
{if Configuration::get('twittertimeline_directtweet')}{assign var='showdirecttweet' value=Configuration::get('twittertimeline_directtweet')}{else}{assign var='showdirecttweet' value='false'}{/if}
{assign var='birdcolor' value=Configuration::get('twittertimeline_birdcolor')}
{assign var='height' value = Configuration::get('twittertimeline_height')}


<script type="text/javascript">

$(document).ready(function () {
	// ------------ Twitter Feed Variables	------------	
	var totaltweets = {$limit}; //Must be a multiple of tweetshift;
    var twitterprofile = "{$twitterprofile}";
	var screenname = "{$twitterprofile}";
    var showdirecttweets = {$showdirecttweet};
    var showretweets = {$showretweet};
    var showtweetlinks = {$showtweetlink};
    var showprofilepic = {$showprofilepic};
	var showtweetactions = {$showtweetactions};
	var showretweetindicator = {$showretweetindicator};
	
	// ------------ Twitter Carousel Variables	------------
	var feedheight = {$height}; 
	var pausetime = {$transitionspeed};
	var slidetime = {$fadingspeed};	
	var tweetshift = 2  //Should be a factor of the total tweets
	var slideinitial = true;
	
	
	var headerHTML = '';
	var loadingHTML = '';
	headerHTML += '<div id="twitter-header"><a href="https://twitter.com/" target="_blank"><img src="{$module_dir}views/img/twitter-bird-light.png" width="34" style="float:left;padding:3px 12px 0px 6px" alt="twitter bird" /></a>';
	headerHTML += '<h1>{l s='Tweets by' mod='twittertimeline'} <span style="font-size:13px"><a href="https://twitter.com/'+twitterprofile+'" target="_blank">@'+twitterprofile+'</a></span></h1></div>';
	loadingHTML += '<div id="loading-container" style="height:'+feedheight+'px;"><img src="{$module_dir}views/img/ajax-loader.gif" width="32" height="32" alt="tweet loader" /></div>';
	
	$('#twitter-feed').html(headerHTML + loadingHTML);
	 
    $.getJSON('{$module_dir}controllers/front/get-tweets1.1.php', 
        function(feeds) {   
            var feedHTML = '';
            var displayCounter = 1;
			         
            for (var i=0; i<feeds.length; i++) {
				var tweetscreenname = feeds[i].user.name;
                var tweetusername = feeds[i].user.screen_name;
                var profileimage = feeds[i].user.profile_image_url_https;
                var status = feeds[i].text; 
				var isaretweet = false;
				var isdirect = false;
				var tweetid = feeds[i].id_str;
				
				
				
				//If the tweet has been retweeted, get the profile pic of the tweeter
				if(typeof feeds[i].retweeted_status != 'undefined'){
				   profileimage = feeds[i].retweeted_status.user.profile_image_url_https;
				   tweetscreenname = feeds[i].retweeted_status.user.name;
				   tweetusername = feeds[i].retweeted_status.user.screen_name;
				   tweetid = feeds[i].retweeted_status.id_str;
				   status = feeds[i].retweeted_status.text; 
				   isaretweet = true;
				 };
				 
				 
				 //Check to see if the tweet is a direct message
				 if (feeds[i].text.substr(0,1) == "@") {
					 isdirect = true;
				 }
				 
				 var pb = "";
				 if (showretweetindicator == true) {
					pb = 'style="padding-bottom:20px;"';
				 }
				 			 
				 //Generate twitter feed HTML based on selected options
				 if (((showretweets == true) || ((isaretweet == false) && (showretweets == false))) && ((showdirecttweets == true) || ((showdirecttweets == false) && (isdirect == false)))) { 
					if ((feeds[i].text.length > 1) && (displayCounter <= totaltweets)) {             
						if (showtweetlinks == true) {
							status = addlinks(status);
						}
						 
						if (displayCounter == 1) {
							feedHTML += headerHTML;
							feedHTML += '<div class="tweets-container" style="height:'+feedheight+'px;">';
						}
						
											
						feedHTML += '<div class="twitter-article" id="t'+displayCounter+'" '+pb+'>'; 										                 
						feedHTML += '<div class="twitter-pic"><a href="https://twitter.com/'+tweetusername+'" target="_blank"><img src="'+profileimage+'"images/twitter-feed-icon.png" width="42" height="42" alt="twitter icon" /></a></div>';
						feedHTML += '<div class="twitter-text"><p><span class="tweetprofilelink"><strong><a href="https://twitter.com/'+tweetusername+'" target="_blank">'+tweetscreenname+'</a></strong> <a href="https://twitter.com/'+tweetusername+'" target="_blank">@'+tweetusername+'</a></span><span class="tweet-time"><a href="https://twitter.com/'+tweetusername+'/status/'+tweetid+'" target="_blank">'+relative_time(feeds[i].created_at)+'</a></span><br/>'+status+'</p>';
						
						if ((isaretweet == true) && (showretweetindicator == true)) {
							feedHTML += '<div id="retweet-indicator"></div>';
						}						
						if (showtweetactions == true) {
							feedHTML += '<div id="twitter-actions"><div class="intent" id="intent-reply"><a href="https://twitter.com/intent/tweet?in_reply_to='+tweetid+'" title="Reply"></a></div><div class="intent" id="intent-retweet"><a href="https://twitter.com/intent/retweet?tweet_id='+tweetid+'" title="Retweet"></a></div><div class="intent" id="intent-fave"><a href="https://twitter.com/intent/favorite?tweet_id='+tweetid+'" title="Favourite"></a></div></div>';
						}
						
						feedHTML += '</div>';
						feedHTML += '</div>';
						
						displayCounter++;
					}   
				 }
            }
			feedHTML += '</div>';
             
            $('#twitter-feed').html(feedHTML);
			
			function tweetcarousel() {
				var currenttweet = 1;
				var lasttweet = totaltweets;
				var tweetheight = new Array();
				var totalheight  = 0;				
				var sliderheight = feedheight;
				
				for (var i=1; i<=totaltweets; i++) {
					tweetheight[i] = parseInt($('#t'+i).css('height')) + parseInt($('#t'+i).css('padding-top')) + parseInt($('#t'+i).css('padding-bottom'));
					//console.log(totalheight);
					if (slideinitial == false) {
						sliderheight = 0;
					}
					if (i > 1) {
			{literal}						
						$('#t'+i).css('top', tweetheight[i-1] + totalheight + sliderheight);
						$('#t'+i).animate({'top':tweetheight[i-1]+ totalheight}, slidetime);						
						totalheight += tweetheight[i-1];
					} else {
						$('#t'+i).css('top', sliderheight);
						$('#t'+i).animate({'top':0}, slidetime);	
					}
					
				
					
				}
				totalheight += tweetheight[totaltweets];
							
				setInterval(scrolltweets, pausetime);
				
				function scrolltweets() {
					var currentheight = 0;
					for (var i=0; i<tweetshift; i++) {
						var nexttweet = currenttweet+i;
						if (nexttweet > totaltweets) {
							nexttweet -= totaltweets;
						}
						//console.log(nexttweet + " "+ currenttweet);
						currentheight += tweetheight[nexttweet];
					}
					
					for (var i=1; i<=totaltweets; i++) {
						//totalheight+=tweetheight[i];
						$('#t'+i).animate({'top': (parseInt($('#t'+i).css('top'))-currentheight) }, slidetime, function(){
							
							var animatedid = parseInt($(this).attr('id').substr(1,2));
							
							if (animatedid==totaltweets) {
								for (j=1; j<=totaltweets; j++) {
									if (parseInt($('#t'+j).css('top')) < -50) {
										var toppos = parseInt($('#t'+lasttweet).css('top')) + tweetheight[lasttweet];
										$('#t'+j).css('top', toppos);
										lasttweet = j;
										
										if (currenttweet >= totaltweets) {
											var newcurrent = currenttweet - totaltweets + 1;
											currenttweet = newcurrent;
										} else {
											currenttweet++;
										};
									}
								}								
								
							}
						});						
					}
					
				}
			}
			
			tweetcarousel();
			
			//Add twitter action animation and rollovers
			if (showtweetactions == true) {				
				$('.twitter-article').hover(function(){
					$(this).find('#twitter-actions').css({'display':'block', 'opacity':0, 'margin-top':-20});
					$(this).find('#twitter-actions').animate({'opacity':1, 'margin-top':0},200);
				}, function() {
					$(this).find('#twitter-actions').animate({'opacity':0, 'margin-top':-20},120, function(){
						$(this).css('display', 'none');
					});
				});			
			{/literal}			
				//Add new window for action clicks
			
				$('#twitter-actions a').click(function(){
					var url = $(this).attr('href');
				  window.open(url, 'tweet action window', 'width=580,height=500');
				  return false;
				});
			}
			
			
    }).error(function(jqXHR, textStatus, errorThrown) {
		var error = "";
			 if (jqXHR.status === 0) {
               error = 'Connection problem. Check file path and www vs non-www in getJSON request';
            } else if (jqXHR.status == 404) {
                error = 'Requested page not found. [404]';
            } else if (jqXHR.status == 500) {
                error = 'Internal Server Error [500].';
            } else if (textStatus === 'parsererror') {
                error = 'Requested JSON parse failed.';
            } else if (textStatus === 'timeout') {
                error = 'Time out error.';
            } else if (textStatus === 'abort') {
                error = 'Ajax request aborted.';
            } else {
                error = 'Uncaught Error.\n' + jqXHR.responseText;
            }	
       		alert("error: " + error);
    });
    

    //Function modified from Stack Overflow
    function addlinks(data) {
        //Add link to all http:// links within tweets
         data = data.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
            return '<a href="'+url+'" >'+url+'</a>';
        });
             
        //Add link to @usernames used within tweets
        data = data.replace(/\B@([_a-z0-9]+)/ig, function(reply) {
            return '<a href="http://twitter.com/'+reply.substring(1)+'" style="font-weight:lighter;" target="_blank">'+reply.charAt(0)+reply.substring(1)+'</a>';
        });
		//Add link to #hastags used within tweets
        data = data.replace(/\B#([_a-z0-9]+)/ig, function(reply) {
            return '<a href="https://twitter.com/search?q='+reply.substring(1)+'" style="font-weight:lighter;" target="_blank">'+reply.charAt(0)+reply.substring(1)+'</a>';
        });
        return data;
    }
     
     
    function relative_time(time_value) {
      var values = time_value.split(" ");
      time_value = values[1] + " " + values[2] + ", " + values[5] + " " + values[3];
      var parsed_date = Date.parse(time_value);
      var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
      var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
	  var shortdate = time_value.substr(4,2) + " " + time_value.substr(0,3);
      delta = delta + (relative_to.getTimezoneOffset() * 60);
     
      if (delta < 60) {
        return '1m';
      } else if(delta < 120) {
        return '1m';
      } else if(delta < (60*60)) {
        return (parseInt(delta / 60)).toString() + 'm';
      } else if(delta < (120*60)) {
        return '1h';
      } else if(delta < (24*60*60)) {
        return (parseInt(delta / 3600)).toString() + 'h';
      } else if(delta < (48*60*60)) {
        //return '1 day';
		return shortdate;
      } else {
        return shortdate;
      }
    }
     
});
</script>

<div class="block">
	<h4 class="title_block">{l s='TWITTER TIMELINE' mod='twittertimeline'}</h4>
    <div class="block_content">
		<div id="twitter-feed"></div>
	</div>
</div>
<!--TWITTER TIMELINE BY megventure.com-->
{/if}