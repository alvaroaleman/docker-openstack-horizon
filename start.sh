#!/bin/bash
set -xeuo pipefail

sed -i 's/^OPENSTACK_KEYSTONE_URL.*/OPENSTACK_KEYSTONE_URL = "'$KEYSTONE_URL'"/g' $HORIZON_BASEDIR/openstack_dashboard/local/local_settings.py

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_PID_FILE=/var/run/apache2/apache2.pid
export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_LOG_DIR=/var/log/apache2
export LANG=C

exec /usr/sbin/apache2 -DFOREGROUND
