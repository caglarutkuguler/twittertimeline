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
 *    This program is not a free software: you can't redistribute it and/|| modify
 *    it. All rights reserved to MEG Venture.
 *
 *    This copyright notice  and licence should be retained in all modules based on this framework.
 *    This does not affect your rights to assert copyright over your own original work.
 *    However, the license of the twitter timeline used in this module is provided below.
 *    This license is also in force.
 *    JQuery Twitter Feed. Coded by Tom Elliott @ www.webdevdoor.com (2013) based on https://twitter.com/javascripts/blogger.js
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class TwitterTimeline extends Module
{
    private $_html = '';
    private $_postErrors = array();

    public $height;
    public $username;
    public $transitionspeed;
    public $startfrom;
    public $tweetlimit;
    public $linkcolor;
    public $textcolor;
    public $birdcolor;
    public $fadingeffect;
    public $showtweetlink;
    public $showretweet;
    public $position;
    public $profilepic;
    public $tweetaction;
    public $retweetindicator;
    public $displayheader;
    public $directtweet;
    public $consumerkey;
    public $consumersecret;
    public $accesstoken;
    public $accesstokensecret;

    public function __construct()
    {
        $this->name = 'twittertimeline';
        $this->tab = 'front_office_features';
        $this->version = '3.1.0';
        $this->bootstrap = true;
        $this->author = 'MEG Venture';
        $this->module_key = "14fcb1e53505a501f39458b0aaa39229";
        $this->username = Configuration::get($this->name . '_username');
        $this->numtweets = Configuration::get($this->name . '_tweetlimit');
        $this->consumerkey = Configuration::get($this->name . '_consumerkey');
        $this->consumersecret = Configuration::get($this->name . '_consumersecret');
        $this->accesstoken = Configuration::get($this->name . '_accesstoken');
        $this->accesstokensecret = Configuration::get($this->name . '_accesstokensecre');

        $config = Configuration::getMultiple(array($this->name . '_height', $this->name . '_username', $this->name . 'startfrom', $this->name . '_transitionspeed', $this->name . '_tweetlimit', $this->name . '_linkcolor', $this->name . '_textcolor', $this->name . '_birdcolor', $this->name . '_fadingeffect', $this->name . '_showtweetlink', $this->name . '_showretweet', $this->name . '_position', $this->name . '_profilepic', $this->name . '_tweetaction', $this->name . '_retweetindicator', $this->name . '_displayheader', $this->name . '_directtweet', $this->name . '_consumerkey', $this->name . '_consumersecret', $this->name . '_accesstoken', $this->name . '_accesstokensecre'));

        if (isset($config[$this->name . '_height'])) {
            $this->height = $config[$this->name . '_height'];
        }

        if (isset($config[$this->name . '_transitionspeed'])) {
            $this->transitionspeed = $config[$this->name . '_transitionspeed'];
        }

        if (isset($config[$this->name . '_startfrom'])) {
            $this->startfrom = $config[$this->name . '_startfrom'];
        }

        if (isset($config[$this->name . '_username'])) {
            $this->username = $config[$this->name . '_username'];
        }

        if (isset($config[$this->name . '_tweetlimit'])) {
            $this->tweetlimit = $config[$this->name . '_tweetlimit'];
        }

        if (isset($config[$this->name . '_linkcolor'])) {
            $this->linkcolor = $config[$this->name . '_linkcolor'];
        }

        if (isset($config[$this->name . '_textcolor'])) {
            $this->textcolor = $config[$this->name . '_textcolor'];
        }

        if (isset($config[$this->name . '_birdcolor'])) {
            $this->birdcolor = $config[$this->name . '_birdcolor'];
        }

        if (isset($config[$this->name . '_fadingeffect'])) {
            $this->fadingeffect = $config[$this->name . '_fadingeffect'];
        }

        if (isset($config[$this->name . '_showtweetlink'])) {
            $this->showtweetlink = $config[$this->name . '_showtweetlink'];
        }

        if (isset($config[$this->name . '_showretweet'])) {
            $this->showretweet = $config[$this->name . '_showretweet'];
        }

        if (isset($config[$this->name . '_position'])) {
            $this->position = $config[$this->name . '_position'];
        }

        if (isset($config[$this->name . '_profilepic'])) {
            $this->profilepic = $config[$this->name . '_profilepic'];
        }

        if (isset($config[$this->name . '_tweetaction'])) {
            $this->tweetaction = $config[$this->name . '_tweetaction'];
        }

        if (isset($config[$this->name . '_retweetindicator'])) {
            $this->retweetindicator = $config[$this->name . '_retweetindicator'];
        }

        if (isset($config[$this->name . '_displayheader'])) {
            $this->displayheader = $config[$this->name . '_displayheader'];
        }

        if (isset($config[$this->name . '_directtweet'])) {
            $this->directtweet = $config[$this->name . '_directtweet'];
        }

        if (isset($config[$this->name . '_consumerkey'])) {
            $this->consumerkey = $config[$this->name . '_consumerkey'];
        }

        if (isset($config[$this->name . '_consumersecret'])) {
            $this->consumersecret = $config[$this->name . '_consumersecret'];
        }

        if (isset($config[$this->name . '_accesstoken'])) {
            $this->accesstoken = $config[$this->name . '_accesstoken'];
        }

        if (isset($config[$this->name . '_accesstokensecre'])) {
            $this->accesstokensecret = $config[$this->name . '_accesstokensecre'];
        }

        parent::__construct(); // The parent construct is required for translations

        $this->page = basename(__FILE__, '.php');
        $this->displayName = $this->l('Twitter Timeline Slider');
        $this->description = $this->l('Use this module to display your twitter timeline sliding on your online store');
        $this->confirmUninstall = $this->l('Are you sure you want to delete your details?');
        if (!isset($this->username) || !isset($this->consumerkey) || !isset($this->consumersecret) || !isset($this->accesstoken) || !isset($this->accesstokensecret)) {
            $this->warning = $this->l('Twitter Timeline Slider authenticaiton info (username, consumer key, consumer secret, access token and access token secret) must be configured in order to use this module correctly. Please refer to <a href=../{$module_dir}readme_en.pdf>the Installation and User Guide</a>.');
        }

        /* Backward compatibility */
        if (version_compare(_PS_VERSION_, '1.5.0.0 ', '<')) {
            require _PS_MODULE_DIR_ . $this->name . '/backward_compatibility/backward.php';
        }

        $path = dirname(__FILE__);
        if (strpos(__FILE__, 'Module.php') !== false) {
            $path .= '/../modules/' . $this->name;
        }
    }

    public function install()
    {
        if (!parent::install()
            || !$this->registerHook('leftColumn')
            || !$this->registerHook('rightColumn')
            || !$this->registerHook('footer')
            || !$this->registerHook('home')
            || !$this->registerHook('header')) {
            return false;
        }
        if (_PS_VERSION_ > '1.7.0') {
            if (!Db::getInstance()->Execute('
            INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
            VALUES("","twittertimeline_height", "140", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
                return false;
            }
        } else {
            if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_height", "105", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
                return false;
            }
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_username", "megventure", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_transitionspeed", "5000", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_startfrom", "1", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_tweetlimit", "16", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_linkcolor", "#cc0000", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_textcolor", "#cc0000", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_birdcolor", "#62d1f4", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_fadingeffect", "500", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_showtweetlink", "true", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_showretweet", "true", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_position", "footer", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_profilepic", "true", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_tweetaction", "true", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_retweetindicator", "true", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_displayheader", "true", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_directtweet", "true", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_consumerkey", "aHJAzNWxjVRe4fjEkcIQ", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_consumersecret", "Op7gQZBuUkvHuuSi8ZweULpe0F3Fpdwrxw7DtFR0Z4", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_accesstoken", "855176100-G9alhRzFk6Afuqeluun1nwsTvS9tUOGYhOn2c3OX", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        if (!Db::getInstance()->Execute('
		INSERT INTO `' . _DB_PREFIX_ . 'configuration`(`id_configuration`, `name`, `value`, `date_add`, `date_upd`)
		VALUES("","twittertimeline_accesstokensecre", "FSqM7rxU86mhSg7BZf0vzzLkYuwNQaqz9Bu0u0T4CPqgv", "2012-03-29 00:08:22", "2012-04-02 12:42:16")')) {
            return false;
        }

        return true;
    }

    public function uninstall()
    {
        if (!Configuration::deleteByName($this->name . '_height')
            || !Configuration::deleteByName($this->name . '_username')
            || !Configuration::deleteByName($this->name . '_transitionspeed')
            || !Configuration::deleteByName($this->name . '_startfrom')
            || !Configuration::deleteByName($this->name . '_tweetlimit')
            || !Configuration::deleteByName($this->name . '_linkcolor')
            || !Configuration::deleteByName($this->name . '_textcolor')
            || !Configuration::deleteByName($this->name . '_birdcolor')
            || !Configuration::deleteByName($this->name . '_fadingeffect')
            || !Configuration::deleteByName($this->name . '_showtweetlink')
            || !Configuration::deleteByName($this->name . '_showretweet')
            || !Configuration::deleteByName($this->name . '_position')
            || !Configuration::deleteByName($this->name . '_profilepic')
            || !Configuration::deleteByName($this->name . '_tweetaction')
            || !Configuration::deleteByName($this->name . '_retweetindicator')
            || !Configuration::deleteByName($this->name . '_displayheader')
            || !Configuration::deleteByName($this->name . '_directtweet')
            || !Configuration::deleteByName($this->name . '_consumerkey')
            || !Configuration::deleteByName($this->name . '_consumersecret')
            || !Configuration::deleteByName($this->name . '_accesstoken')
            || !Configuration::deleteByName($this->name . '_accesstokensecre')
            || !parent::uninstall()) {
            return false;
        }

        return true;
    }

    private function _postValidation()
    {
        if (Tools::isSubmit('submit')) {
            if (!Tools::getValue('usernameA')) {
                $this->_postErrors[] = $this->l('Changes are not saved. Twitter username is required. Please refer to the readme file.');
            } elseif (!Tools::getValue('consumerkeyA')) {
                $this->_postErrors[] = $this->l('Changes are not saved. Twitter consumer key is required. Please refer to the readme file.');
            } elseif (!Tools::getValue('consumersecretA')) {
                $this->_postErrors[] = $this->l('Changes are not saved. Twitter consumer secret is required. Please refer to the readme file.');
            } elseif (!Tools::getValue('accesstokenA')) {
                $this->_postErrors[] = $this->l('Changes are not saved. Twitter access token is required. Please refer to the readme file.');
            } elseif (!Tools::getValue('accesstokensecretA')) {
                $this->_postErrors[] = $this->l('Changes are not saved. Twitter access token secret is required. Please refer to the readme file.');
            }
        }
    }

    public function getContent()
    {
        if (Tools::isSubmit('submit')) {
            $this->_postValidation();
            if (!sizeof($this->_postErrors)) {
                $this->_postProcess();
            } else {
                foreach ($this->_postErrors as $err) {
                    $this->_html .= $this->displayError($err);
                }
            }
        }

        $this->smarty->assign(array(
            'ps_base_uri' => __PS_BASE_URI__,
            'action_uri' => htmlentities($_SERVER['REQUEST_URI']),
            'username' => Configuration::get($this->name . '_username'),
            'consumerkey' => Configuration::get($this->name . '_consumerkey'),
            'consumersecret' => Configuration::get($this->name . '_consumersecret'),
            'accesstoken' => Configuration::get($this->name . '_accesstoken'),
            'accesstokensecre' => Configuration::get($this->name . '_accesstokensecre'),
            'height' => Configuration::get($this->name . '_height'),
            'transitionspeed' => Configuration::get($this->name . '_transitionspeed'),
            'fadingeffect' => Configuration::get($this->name . '_fadingeffect'),
            'tweetlimit' => Configuration::get($this->name . '_tweetlimit'),
            'startfrom' => Configuration::get($this->name . '_startfrom'),
            'position' => Configuration::get($this->name . '_position'),
            'textcolor' => Configuration::get($this->name . '_textcolor'),
            'linkcolor' => Configuration::get($this->name . '_linkcolor'),
            'birdcolor' => Configuration::get($this->name . '_birdcolor'),
            'showretweet' => Configuration::get($this->name . '_showretweet'),
            'showtweetlink' => Configuration::get($this->name . '_showtweetlink'),
            'profilepic' => Configuration::get($this->name . '_profilepic'),
            'tweetaction' => Configuration::get($this->name . '_tweetaction'),
            'retweetindicator' => Configuration::get($this->name . '_retweetindicator'),
            'displayheader' => Configuration::get($this->name . '_displayheader'),
            'directtweet' => Configuration::get($this->name . '_directtweet'),
            'thispath' => $this->_path,
        ));

        $displayform = $this->display(__FILE__, 'views/templates/admin/configure.tpl');
        return $this->_html . $displayform;
    }

    private function _postProcess()
    {
        Configuration::updateValue($this->name . '_height', Tools::getValue('heightA'));
        Configuration::updateValue($this->name . '_username', Tools::getValue('usernameA'));
        Configuration::updateValue($this->name . '_transitionspeed', Tools::getValue('transitionspeedA'));
        Configuration::updateValue($this->name . '_startfrom', Tools::getValue('startfromA'));
        Configuration::updateValue($this->name . '_tweetlimit', Tools::getValue('tweetlimitA'));
        Configuration::updateValue($this->name . '_linkcolor', Tools::getValue('linkcolorA'));
        Configuration::updateValue($this->name . '_textcolor', Tools::getValue('textcolorA'));
        Configuration::updateValue($this->name . '_birdcolor', Tools::getValue('birdcolorA'));
        Configuration::updateValue($this->name . '_fadingeffect', Tools::getValue('fadingeffectA'));
        Configuration::updateValue($this->name . '_showtweetlink', Tools::getValue('showtweetlinkA'));
        Configuration::updateValue($this->name . '_showretweet', Tools::getValue('showretweetA'));
        Configuration::updateValue($this->name . '_position', Tools::getValue('positionA'));
        Configuration::updateValue($this->name . '_profilepic', Tools::getValue('profilepicA'));
        Configuration::updateValue($this->name . '_tweetaction', Tools::getValue('tweetactionA'));
        Configuration::updateValue($this->name . '_retweetindicator', Tools::getValue('retweetindicatorA'));
        Configuration::updateValue($this->name . '_displayheader', Tools::getValue('displayheaderA'));
        Configuration::updateValue($this->name . '_directtweet', Tools::getValue('directtweetA'));
        Configuration::updateValue($this->name . '_consumerkey', Tools::getValue('consumerkeyA'));
        Configuration::updateValue($this->name . '_consumersecret', Tools::getValue('consumersecretA'));
        Configuration::updateValue($this->name . '_accesstoken', Tools::getValue('accesstokenA'));
        Configuration::updateValue($this->name . '_accesstokensecre', Tools::getValue('accesstokensecretA'));

        $this->_html .= $this->displayConfirmation($this->l('Settings updated successfully.'));
    }

    public function _isCurl()
    {
        return function_exists('curl_version');
    }

    public function hookHeader()
    {
        if (_PS_VERSION_ > '1.7.0') {
            $this->context->controller->addJquery();
            $this->context->controller->registerJavascript(
                'remote-jquery',
                '//code.jquery.com/jquery-1.12.0.min.js',
                array(
                    'server' => 'remote',
                    'position' => 'head',
                    'priority' => 20,
                )
            );
        }
        $this->smarty->assign('module_dir', _PS_MODULE_DIR_ . $this->name);
        return $this->display(__FILE__, 'views/templates/front/bottom_left_button.tpl');
    }

    public function hookLeftColumn($params)
    {
        $this->smarty->assign('module_dir', _PS_MODULE_DIR_ . $this->name);
        if (version_compare(_PS_VERSION_, '1.7.0.0 ', '>')) {
            return $this->display(__FILE__, 'views/templates/front/1.7/blocktwittertimeline.tpl');
        } elseif (version_compare(_PS_VERSION_, '1.6.0.0 ', '>') && version_compare(_PS_VERSION_, '1.7.0.0 ', '<')) {
            return $this->display(__FILE__, 'views/templates/front/1.6/blocktwittertimeline.tpl');
        } else {
            return $this->display(__FILE__, 'views/templates/front/1.5/blocktwittertimeline.tpl');
        }
    }

    public function hookRightColumn($params)
    {
        $this->smarty->assign('module_dir', _PS_MODULE_DIR_ . $this->name);
        if (version_compare(_PS_VERSION_, '1.7.0.0 ', '>')) {
            return $this->display(__FILE__, 'views/templates/front/1.7/blocktwittertimeline_right.tpl');
        } elseif (version_compare(_PS_VERSION_, '1.6.0.0 ', '>') && version_compare(_PS_VERSION_, '1.7.0.0 ', '<')) {
            return $this->display(__FILE__, 'views/templates/front/1.6/blocktwittertimeline_right.tpl');
        } else {
            return $this->display(__FILE__, 'views/templates/front/1.5/blocktwittertimeline_right.tpl');
        }
    }

    public function hookFooter($params)
    {
        $this->smarty->assign('module_dir', _PS_MODULE_DIR_ . $this->name);
        if (version_compare(_PS_VERSION_, '1.7.0.0 ', '>')) {
            return $this->display(__FILE__, 'views/templates/front/1.7/blocktwittertimeline_footer.tpl');
        } elseif (version_compare(_PS_VERSION_, '1.6.0.0 ', '>') && version_compare(_PS_VERSION_, '1.7.0.0 ', '<')) {
            return $this->display(__FILE__, 'views/templates/front/1.6/blocktwittertimeline_footer.tpl');
        } else {
            return $this->display(__FILE__, 'views/templates/front/1.5/blocktwittertimeline_footer.tpl');
        }
    }

    public function hookhome($params)
    {
        $this->smarty->assign('module_dir', _PS_MODULE_DIR_ . $this->name);
        if (version_compare(_PS_VERSION_, '1.7.0.0 ', '>')) {
            return $this->display(__FILE__, 'views/templates/front/1.7/blocktwittertimeline_home.tpl');
        } elseif (version_compare(_PS_VERSION_, '1.6.0.0 ', '>') && version_compare(_PS_VERSION_, '1.7.0.0 ', '<')) {
            return $this->display(__FILE__, 'views/templates/front/1.6/blocktwittertimeline_home.tpl');
        } else {
            return $this->display(__FILE__, 'views/templates/front/1.5/blocktwittertimeline_home.tpl');
        }
    }
}
