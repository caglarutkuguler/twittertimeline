<?php
/**
 * @author    MEG Venture <info@megventure.com>
 * @copyright 2007-2026 MEG Venture
 * @license   All rights reserved
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

function upgrade_module_4_0_1($module)
{
    return $module->registerHook('actionFrontControllerSetMedia');
}
