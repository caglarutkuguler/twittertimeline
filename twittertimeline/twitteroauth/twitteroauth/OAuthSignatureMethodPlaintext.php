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
 * The PLAINTEXT method does not provide any security protection and SHOULD only be used
 * over a secure channel such as HTTPS. It does not use the Signature Base String.
 *   - Chapter 9.4 ("PLAINTEXT")
 */
class OAuthSignatureMethodPlaintext extends OAuthSignatureMethod
{
    public function get_name()
    {
        return "PLAINTEXT";
    }

    /**
     * oauth_signature is set to the concatenated encoded values of the Consumer Secret and
     * Token Secret, separated by a '&' character (ASCII code 38), even if either secret is
     * empty. The result MUST be encoded again.
     *   - Chapter 9.4.1 ("Generating Signatures")
     *
     * Please note that the second encoding MUST NOT happen in the SignatureMethod, as
     * OAuthRequest handles this!
     */
    public function build_signature($request, $consumer, $token)
    {
        $key_parts = array(
            $consumer->secret,
            ($token) ? $token->secret : "",
        );

        $key_parts = OAuthUtil::UrlencodeRfc3986($key_parts);
        $key = implode('&', $key_parts);
        $request->base_string = $key;

        return $key;
    }
}
