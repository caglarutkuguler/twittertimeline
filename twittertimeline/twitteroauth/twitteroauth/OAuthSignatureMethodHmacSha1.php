<?php
/**
 *    Module Name: Twitter Timeline Slider
 *
 *    Module URI: Please contact with info@megventure.com
 *    Description: Use this module to display your twitter timeline sliding on your online store
 *    Version: 3.1.0
 *
 *  @author    MEG Venture <info@megventure.com>
 *  @copyright 2007-2021 MEG Venture
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

/**
 * The HMAC-SHA1 signature method uses the HMAC-SHA1 signature algorithm as defined in [RFC2104]
 * where the Signature Base String is the text and the key is the concatenated values (each first
 * encoded per Parameter Encoding) of the Consumer Secret and Token Secret, separated by an '&'
 * character (ASCII code 38) even if empty.
 *   - Chapter 9.2 ("HMAC-SHA1")
 */
class OAuthSignatureMethodHmacSha1 extends OAuthSignatureMethod
{
    public function get_name()
    {
        return "HMAC-SHA1";
    }

    public function build_signature($request, $consumer, $token)
    {
        $base_string = $request->get_signature_base_string();
        $request->base_string = $base_string;

        $key_parts = array(
            $consumer->secret,
            ($token) ? $token->secret : "",
        );

        $key_parts = OAuthUtil::UrlencodeRfc3986($key_parts);
        $key = implode('&', $key_parts);

        return base64_encode(hash_hmac('sha1', $base_string, $key, true));
    }
}
