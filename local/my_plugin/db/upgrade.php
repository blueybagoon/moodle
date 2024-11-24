<?php
defined('MOODLE_INTERNAL') || die();

function xmldb_local_($oldversion) {
    global $DB;

    $dbman = $DB->get_manager();

    // Moodle v3.6.0 release upgrade line.
    // Put any upgrade step following this.

    return true;
}
