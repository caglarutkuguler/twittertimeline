<?php
/**
 * @author    MEG Venture <info@megventure.com>
 * @copyright 2007-2026 MEG Venture
 * @license   All rights reserved
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class TwitterTimeline extends Module
{
    const POSITIONS = ['left', 'right', 'footer', 'home', 'floating'];
    const DISPLAY_MODES = ['fixed', 'scroll'];
    const CHROME_FLAGS = [
        'CHROME_NOHEADER' => 'noheader',
        'CHROME_NOFOOTER' => 'nofooter',
        'CHROME_NOBORDERS' => 'noborders',
        'CHROME_TRANSPARENT' => 'transparent',
    ];

    public function __construct()
    {
        $this->name = 'twittertimeline';
        $this->tab = 'front_office_features';
        $this->version = '4.0.5';
        $this->author = 'MEG Venture';
        $this->module_key = '14fcb1e53505a501f39458b0aaa39229';
        $this->need_instance = 0;
        $this->bootstrap = true;
        $this->ps_versions_compliancy = ['min' => '1.7.0.0', 'max' => _PS_VERSION_];

        parent::__construct();

        $this->displayName = $this->l('Twitter and X Feed Widget');
        $this->description = $this->l('Show your live Twitter/X timeline anywhere on your store. No API keys, no developer account, just your username.');
        $this->confirmUninstall = $this->l('Are you sure you want to remove your Twitter/X feed settings?');

        if (!Configuration::get('TWITTERTIMELINE_USERNAME')) {
            $this->warning = $this->l('Enter your Twitter/X username on the configuration page to activate this module.');
        }
    }

    public function install()
    {
        if (!parent::install() || !$this->registerHook($this->getHookNames())) {
            return false;
        }

        return $this->saveConfiguration($this->getDefaultConfiguration());
    }

    public function uninstall()
    {
        foreach (array_keys($this->getDefaultConfiguration()) as $key) {
            Configuration::deleteByName($key);
        }

        return parent::uninstall();
    }

    private function getHookNames()
    {
        return ['displayLeftColumn', 'displayRightColumn', 'displayHome', 'displayFooter', 'actionFrontControllerSetMedia'];
    }

    private function getDefaultConfiguration()
    {
        return [
            'TWITTERTIMELINE_USERNAME' => '',
            'TWITTERTIMELINE_POSITION' => 'footer',
            'TWITTERTIMELINE_DISPLAY_MODE' => 'fixed',
            'TWITTERTIMELINE_TWEET_LIMIT' => 5,
            'TWITTERTIMELINE_HEIGHT' => 400,
            'TWITTERTIMELINE_THEME' => 'light',
            'TWITTERTIMELINE_LINK_COLOR' => '',
            'TWITTERTIMELINE_CHROME_NOHEADER' => 0,
            'TWITTERTIMELINE_CHROME_NOFOOTER' => 0,
            'TWITTERTIMELINE_CHROME_NOBORDERS' => 0,
            'TWITTERTIMELINE_CHROME_TRANSPARENT' => 0,
            'TWITTERTIMELINE_DNT' => 1,
            'TWITTERTIMELINE_HIDE_TUTORIAL' => 0,
        ];
    }

    private function saveConfiguration(array $values)
    {
        foreach ($values as $key => $value) {
            if (!Configuration::updateValue($key, $value)) {
                return false;
            }
        }

        return true;
    }

    public static function isValidUsername($username)
    {
        return (bool) preg_match('/^[A-Za-z0-9_]{1,15}$/', $username);
    }

    public function getContent()
    {
        $output = '';

        if (Tools::isSubmit('submitTwitterTimeline')) {
            $output .= $this->processConfigurationForm();
        }

        if (Tools::isSubmit('submitTwitterTimelineTutorial')) {
            Configuration::updateValue('TWITTERTIMELINE_HIDE_TUTORIAL', 1);
        }

        return $output . $this->renderConfigurationPage();
    }

    private function processConfigurationForm()
    {
        $errors = [];

        $username = ltrim(trim(Tools::getValue('TWITTERTIMELINE_USERNAME')), '@');
        if ($username !== '' && !self::isValidUsername($username)) {
            $errors[] = $this->l('Please enter a valid Twitter/X username: letters, numbers and underscores only, up to 15 characters, without the @ symbol.');
        }

        $position = Tools::getValue('TWITTERTIMELINE_POSITION');
        if (!in_array($position, self::POSITIONS, true)) {
            $position = 'footer';
        }

        $display_mode = Tools::getValue('TWITTERTIMELINE_DISPLAY_MODE');
        if (!in_array($display_mode, self::DISPLAY_MODES, true)) {
            $display_mode = 'fixed';
        }

        $tweet_limit = max(1, min(20, (int) Tools::getValue('TWITTERTIMELINE_TWEET_LIMIT', 5)));
        $height = max(200, min(1200, (int) Tools::getValue('TWITTERTIMELINE_HEIGHT', 400)));
        $theme = Tools::getValue('TWITTERTIMELINE_THEME') === 'dark' ? 'dark' : 'light';

        $link_color = trim(Tools::getValue('TWITTERTIMELINE_LINK_COLOR'));
        if ($link_color !== '' && !preg_match('/^#[0-9A-Fa-f]{6}$/', $link_color)) {
            $errors[] = $this->l('The accent color must be a valid hex color, e.g. #1DA1F2.');
            $link_color = '';
        }

        if ($errors) {
            $output = '';
            foreach ($errors as $error) {
                $output .= $this->displayError($error);
            }

            return $output;
        }

        $this->saveConfiguration([
            'TWITTERTIMELINE_USERNAME' => $username,
            'TWITTERTIMELINE_POSITION' => $position,
            'TWITTERTIMELINE_DISPLAY_MODE' => $display_mode,
            'TWITTERTIMELINE_TWEET_LIMIT' => $tweet_limit,
            'TWITTERTIMELINE_HEIGHT' => $height,
            'TWITTERTIMELINE_THEME' => $theme,
            'TWITTERTIMELINE_LINK_COLOR' => $link_color,
            'TWITTERTIMELINE_CHROME_NOHEADER' => (int) Tools::getValue('TWITTERTIMELINE_CHROME_NOHEADER'),
            'TWITTERTIMELINE_CHROME_NOFOOTER' => (int) Tools::getValue('TWITTERTIMELINE_CHROME_NOFOOTER'),
            'TWITTERTIMELINE_CHROME_NOBORDERS' => (int) Tools::getValue('TWITTERTIMELINE_CHROME_NOBORDERS'),
            'TWITTERTIMELINE_CHROME_TRANSPARENT' => (int) Tools::getValue('TWITTERTIMELINE_CHROME_TRANSPARENT'),
            'TWITTERTIMELINE_DNT' => (int) Tools::getValue('TWITTERTIMELINE_DNT'),
        ]);

        return $this->displayConfirmation($this->l('Settings updated successfully.'));
    }

    private function renderConfigurationPage()
    {
        $this->context->smarty->assign([
            'twittertimeline_action_uri' => htmlentities($_SERVER['REQUEST_URI']),
            'twittertimeline_username' => Configuration::get('TWITTERTIMELINE_USERNAME'),
            'twittertimeline_position' => Configuration::get('TWITTERTIMELINE_POSITION'),
            'twittertimeline_display_mode' => Configuration::get('TWITTERTIMELINE_DISPLAY_MODE'),
            'twittertimeline_tweet_limit' => Configuration::get('TWITTERTIMELINE_TWEET_LIMIT'),
            'twittertimeline_height' => Configuration::get('TWITTERTIMELINE_HEIGHT'),
            'twittertimeline_theme' => Configuration::get('TWITTERTIMELINE_THEME'),
            'twittertimeline_link_color' => Configuration::get('TWITTERTIMELINE_LINK_COLOR'),
            'twittertimeline_chrome_noheader' => (bool) Configuration::get('TWITTERTIMELINE_CHROME_NOHEADER'),
            'twittertimeline_chrome_nofooter' => (bool) Configuration::get('TWITTERTIMELINE_CHROME_NOFOOTER'),
            'twittertimeline_chrome_noborders' => (bool) Configuration::get('TWITTERTIMELINE_CHROME_NOBORDERS'),
            'twittertimeline_chrome_transparent' => (bool) Configuration::get('TWITTERTIMELINE_CHROME_TRANSPARENT'),
            'twittertimeline_dnt' => (bool) Configuration::get('TWITTERTIMELINE_DNT'),
            'twittertimeline_hide_tutorial' => (bool) Configuration::get('TWITTERTIMELINE_HIDE_TUTORIAL'),
            'twittertimeline_chrome_attr' => $this->getChromeAttribute(),
            'twittertimeline_widget_lang' => $this->getWidgetLang(),
            'twittertimeline_module_dir' => $this->_path,
        ]);

        return $this->display(__FILE__, 'views/templates/admin/configure.tpl');
    }

    private function getChromeAttribute()
    {
        $flags = [];
        foreach (self::CHROME_FLAGS as $config_suffix => $chrome_value) {
            if (Configuration::get('TWITTERTIMELINE_' . $config_suffix)) {
                $flags[] = $chrome_value;
            }
        }

        return implode(' ', $flags);
    }

    private function getWidgetLang()
    {
        $iso_code = $this->context->language->iso_code;

        return $iso_code ? Tools::strtolower($iso_code) : 'en';
    }

    public function hookActionFrontControllerSetMedia($params)
    {
        if (!self::isValidUsername(Configuration::get('TWITTERTIMELINE_USERNAME'))) {
            return;
        }

        $this->context->controller->registerStylesheet(
            'twittertimeline-css',
            'modules/' . $this->name . '/views/css/twittertimeline.css'
        );
    }

    private function renderWidget($position)
    {
        if (Configuration::get('TWITTERTIMELINE_POSITION') !== $position) {
            return '';
        }

        $username = Configuration::get('TWITTERTIMELINE_USERNAME');
        if (!self::isValidUsername($username)) {
            return '';
        }

        $this->context->smarty->assign([
            'twittertimeline_username' => $username,
            'twittertimeline_position' => $position,
            'twittertimeline_display_mode' => Configuration::get('TWITTERTIMELINE_DISPLAY_MODE'),
            'twittertimeline_tweet_limit' => (int) Configuration::get('TWITTERTIMELINE_TWEET_LIMIT'),
            'twittertimeline_height' => (int) Configuration::get('TWITTERTIMELINE_HEIGHT'),
            'twittertimeline_theme' => Configuration::get('TWITTERTIMELINE_THEME'),
            'twittertimeline_link_color' => Configuration::get('TWITTERTIMELINE_LINK_COLOR'),
            'twittertimeline_chrome_attr' => $this->getChromeAttribute(),
            'twittertimeline_dnt' => (bool) Configuration::get('TWITTERTIMELINE_DNT'),
            'twittertimeline_widget_lang' => $this->getWidgetLang(),
        ]);

        return $this->display(__FILE__, 'views/templates/hook/twittertimeline.tpl');
    }

    public function hookDisplayLeftColumn($params)
    {
        return $this->renderWidget('left');
    }

    public function hookDisplayRightColumn($params)
    {
        return $this->renderWidget('right');
    }

    public function hookDisplayHome($params)
    {
        return $this->renderWidget('home');
    }

    public function hookDisplayFooter($params)
    {
        if (Configuration::get('TWITTERTIMELINE_POSITION') === 'floating') {
            return $this->renderWidget('floating');
        }

        return $this->renderWidget('footer');
    }
}
