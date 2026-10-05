<?php
/**
 * @author    MEG Venture <info@megventure.com>
 * @copyright 2007-2026 MEG Venture & Consulting Ltd.
 * @license   https://opensource.org/licenses/MIT MIT License
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

/**
 * 4.2.1 -> 4.2.2: the seven locale files are translated for the first time.
 *
 * Values in translations/<iso>.php only — no key changed, so nothing in the
 * database needs migrating and no configuration value is touched.
 *
 * `{l s='...' mod='twittertimeline'}` compiles to a *runtime* smartyTranslate()
 * call, so a stale compiled template is not the risk here; the risk is Smarty's
 * output cache, which stores already-rendered HTML and would keep serving the
 * old English on a shop with template caching on. Dropping it is the whole job.
 *
 * Media::clearCache() is deliberately not called: this release changes no .css
 * and no .js, so no bundle can be stale.
 *
 * @param Module $module
 *
 * @return bool
 */
function upgrade_module_4_2_2($module)
{
    if (method_exists('Tools', 'clearSmartyCache')) {
        Tools::clearSmartyCache();
    }

    if (method_exists('Tools', 'clearCompile')) {
        Tools::clearCompile();
    }

    return true;
}
