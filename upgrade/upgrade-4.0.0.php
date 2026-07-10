<?php
/**
 * @author    MEG Venture <info@megventure.com>
 * @copyright 2007-2026 MEG Venture
 * @license   All rights reserved
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_4_0_0($module)
{
    $username = Configuration::get('twittertimeline_username');
    if ($username && $username !== 'megventure') {
        Configuration::updateValue('TWITTERTIMELINE_USERNAME', ltrim($username, '@'));
    }

    $position_map = ['bottom_left' => 'floating'];
    $position = Configuration::get('twittertimeline_position');
    if ($position) {
        Configuration::updateValue('TWITTERTIMELINE_POSITION', isset($position_map[$position]) ? $position_map[$position] : $position);
    }

    $obsolete_keys = [
        'twittertimeline_height',
        'twittertimeline_username',
        'twittertimeline_transitionspeed',
        'twittertimeline_startfrom',
        'twittertimeline_tweetlimit',
        'twittertimeline_linkcolor',
        'twittertimeline_textcolor',
        'twittertimeline_birdcolor',
        'twittertimeline_fadingeffect',
        'twittertimeline_showtweetlink',
        'twittertimeline_showretweet',
        'twittertimeline_position',
        'twittertimeline_profilepic',
        'twittertimeline_tweetaction',
        'twittertimeline_retweetindicator',
        'twittertimeline_displayheader',
        'twittertimeline_directtweet',
        'twittertimeline_consumerkey',
        'twittertimeline_consumersecret',
        'twittertimeline_accesstoken',
        'twittertimeline_accesstokensecre',
    ];
    foreach ($obsolete_keys as $key) {
        Configuration::deleteByName($key);
    }

    foreach (['leftColumn', 'rightColumn', 'footer', 'home', 'header', 'displayHeader'] as $legacy_hook) {
        $module->unregisterHook($legacy_hook);
    }
    $module->registerHook(['displayLeftColumn', 'displayRightColumn', 'displayHome', 'displayFooter']);

    return true;
}
