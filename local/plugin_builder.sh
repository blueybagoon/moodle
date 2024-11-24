#!/bin/bash

# Check if plugin name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <plugin_name>"
    exit 1
fi

PLUGIN_NAME=$1

# Define the directory structure for the plugin
PLUGIN_DIR=$PLUGIN_NAME
DB_DIR=$PLUGIN_DIR/db
LANG_DIR=$PLUGIN_DIR/lang/en
LIB_DIR=$PLUGIN_DIR/lib
SETTINGS_DIR=$PLUGIN_DIR/settings
VERSION_DIR=$PLUGIN_DIR/version.php

# Create the directory structure
mkdir -p $DB_DIR $LANG_DIR $LIB_DIR $SETTINGS_DIR

# Create the version.php file with basic content
cat <<EOL > $VERSION_DIR
<?php
defined('MOODLE_INTERNAL') || die();

\$plugin->component = 'local_$PLUGIN_NAME';
\$plugin->version   = 2022040100; // The current plugin version (Date: YYYYMMDDXX)
\$plugin->requires  = 2018050800; // Requires this Moodle version
\$plugin->maturity  = MATURITY_STABLE;
\$plugin->release   = 'v1.0';
EOL

# Create the db/upgrade.php file with basic content
cat <<EOL > $DB_DIR/upgrade.php
<?php
defined('MOODLE_INTERNAL') || die();

function xmldb_local_$PLUGIN_NAME_upgrade(\$oldversion) {
    global \$DB;

    \$dbman = \$DB->get_manager();

    // Moodle v3.6.0 release upgrade line.
    // Put any upgrade step following this.

    return true;
}
EOL

# Create the lang/en/local_pluginname.php file with basic content
cat <<EOL > $LANG_DIR/local_$PLUGIN_NAME.php
<?php
\$string['pluginname'] = '$PLUGIN_NAME';
EOL

# Create the settings.php file with basic content
cat <<EOL > $SETTINGS_DIR/settings.php
<?php
defined('MOODLE_INTERNAL') || die();

if (\$hassiteconfig) {
    \$settings = new admin_settingpage('local_$PLUGIN_NAME', get_string('pluginname', 'local_$PLUGIN_NAME'));

    \$ADMIN->add('localplugins', \$settings);
}
EOL

# Create the lib.php file with basic content
cat <<EOL > $LIB_DIR/lib.php
<?php
defined('MOODLE_INTERNAL') || die();
EOL

echo "Moodle plugin structure for '$PLUGIN_NAME' created successfully."
