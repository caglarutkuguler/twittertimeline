<?php
/**
 * @author    MEG Venture <info@megventure.com>
 * @copyright 2007-2026 MEG Venture & Consulting Ltd.
 * @license   https://opensource.org/licenses/MIT MIT License
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_4_1_0($module)
{
    Configuration::updateValue('TWITTERTIMELINE_EMBED_TYPE', 'timeline');
    Configuration::updateValue('TWITTERTIMELINE_TWEET_ID', '');
    Configuration::updateValue('TWITTERTIMELINE_TWEET_HIDE_CONVERSATION', 0);
    Configuration::updateValue('TWITTERTIMELINE_TWEET_HIDE_MEDIA', 0);

    return true;
}
