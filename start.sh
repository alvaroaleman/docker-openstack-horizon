#!/bin/bash
set -xeuo pipefail

# Set Keystone URL
sed -i 's/^OPENSTACK_KEYSTONE_URL.*/OPENSTACK_KEYSTONE_URL = "'$KEYSTONE_URL'"/g' $HORIZON_BASEDIR/openstack_dashboard/local/local_settings.py

# Set WSGI Worker proccesses
export NUM_CPU=$(cat /proc/cpuinfo |grep processor|wc -l)
sed -E -i 's/(.*WSGIDaemonProcess openstack_dashboard_website).*/\1 processes='${NUM_CPU}'/g' /etc/apache2/sites-enabled/horizon.conf

export APACHE_RUN_USER=www-data
export APACHE_RUN_GROUP=www-data
export APACHE_PID_FILE=/var/run/apache2/apache2.pid
export APACHE_RUN_DIR=/var/run/apache2
export APACHE_LOCK_DIR=/var/lock/apache2
export APACHE_LOG_DIR=/var/log/apache2
export LANG=C

exec /usr/sbin/apache2 -DFOREGROUND
