#!/bin/bash
set -xeuo pipefail

# Set Keystone URL
sed -i 's/^OPENSTACK_KEYSTONE_URL.*/OPENSTACK_KEYSTONE_URL = "'$KEYSTONE_URL'"/g' $HORIZON_BASEDIR/openstack_dashboard/local/local_settings.py

# Set WSGI Worker proccesses
export NUM_CPU=$(cat /proc/cpuinfo |grep processor|wc -l)
sed -E -i 's/(.*WSGIDaemonProcess openstack_dashboard_website).*/\1 processes='${NUM_CPU}'/g' /etc/apache2/sites-enabled/horizon.conf

exec /usr/sbin/apache2 -DFOREGROUND
