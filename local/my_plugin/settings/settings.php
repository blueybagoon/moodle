<?php
defined('MOODLE_INTERNAL') || die();

if ($hassiteconfig) {
    $settings = new admin_settingpage('local_my_plugin', get_string('pluginname', 'local_my_plugin'));

    $ADMIN->add('localplugins', $settings);
}
