<?php
/**
 *    Module Name: Twitter Timeline Slider
 *
 *    Module URI: Please contact with info@megventure.com
 *    Description: Use this module to display your twitter timeline sliding on your online store
 *    Version: 3.2.0
 *
 *  @author    MEG Venture <info@megventure.com>
 *  @copyright 2007-2023 MEG Venture
 *  @license   For Prestashop--> http://opensource.org/licenses/osl-3.2.php  Open Software License (OSL 3.2)
 *
 *    This program is not a free software: you can't redistribute it and/or modify
 *    it. All rights reserved to MEG Venture.
 *
 *    This copyright notice  and licence should be retained in all modules based on this framework.
 *    This does not affect your rights to assert copyright over your own original work.
 *    However, the license of the twitter timeline used in this module is provided below.
 *    This license is also in force.
 *    JQuery Twitter Feed. Coded by Tom Elliott @ www.webdevdoor.com (2013) based on https://twitter.com/javascripts/blogger.js
 */

require_once $_SERVER['DOCUMENT_ROOT'] . '/modules/twittertimeline/twitteroauth/twitteroauth/twitteroauth.php'; //Path to twitteroauth library
require_once $_SERVER['DOCUMENT_ROOT'] . '/config/config.inc.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/modules/twittertimeline/twittertimeline.php';

$module = new TwitterTimeline();

$twitteruser = $module->username;
$notweets = $module->numtweets;
$consumerkey = $module->consumerkey;
$consumersecret = $module->consumersecret;
$accesstoken = $module->accesstoken;
$accesstokensecret = $module->accesstokensecret;

function getConnectionWithAccessToken($cons_key, $cons_secret, $oauth_token, $oauth_token_secret)
{
    $connection = new TwitterOAuth($cons_key, $cons_secret, $oauth_token, $oauth_token_secret);
    return $connection;
}

$connection = getConnectionWithAccessToken($consumerkey, $consumersecret, $accesstoken, $accesstokensecret);

$tweets = $connection->get("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" . $twitteruser . "&count=" . $notweets);

echo  json_encode($tweets);
