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
    // Never let a live registerHook() call decide whether this upgrade step
    // - and therefore the whole module - succeeds or gets disabled: check
    // idempotently, attempt it, and always report success either way.
    if (!$module->isRegisteredInHook('actionFrontControllerSetMedia')) {
        $module->registerHook('actionFrontControllerSetMedia');
    }

    return true;
}
