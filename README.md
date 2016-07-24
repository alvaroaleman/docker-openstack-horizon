# docker-openstack-horizon


## Synopsis

```shell
sudo mkdir /var/log/horizon
sudo chown 33 /var/log/horizon
# Must be sed-comptaible regex escaped, use the single quotes!
KEYSTONE_URL=
KEYSTONE_URL='http:\/\/10\.10\.10\.1:5000\/v2\.0'
sudo docker run -d -p 80:80 -v /var/log/horizon:/var/log/apache2:rw -e KEYSTONE_URL=$KEYSTONE_URL alvaroaleman/openstack-horizon
```

## Description

A simple Openstack Horizon image. Debug is set to true. For any advanced configuration,
it is adviced to build your own image based on this using your own configuration:

```shell
FROM alvaroaleman/openstack-horizon

COPY local_settings.py /opt/horizon/openstack_dashboard/local/local_settings.py
```

## LICENSE

AGPLv3

## Author

* Alvaro Aleman
