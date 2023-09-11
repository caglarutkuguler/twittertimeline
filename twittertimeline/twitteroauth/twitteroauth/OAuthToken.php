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

class OAuthToken
{
    // access tokens and request tokens
    public $key;
    public $secret;

    /**
     * key = the token
     * secret = the token secret
     */
    public function __construct($key, $secret)
    {
        $this->key = $key;
        $this->secret = $secret;
    }

    /**
     * generates the basic string serialization of a token that a server
     * would respond to request_token and access_token calls with
     */
    public function to_string()
    {
        return "oauth_token=" .
        OAuthUtil::UrlencodeRfc3986($this->key) .
        "&oauth_token_secret=" .
        OAuthUtil::UrlencodeRfc3986($this->secret);
    }

    public function __toString()
    {
        return $this->to_string();
    }
}
