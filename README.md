# docker-openstack-horizon


## Synopsis

```shell
sudo mkdir /var/log/horizon
sudo chown 33 /var/log/horizon
sudo docker run -d \
  -p 80:80 \
  -v /var/log/horizon:/var/log/apache2:rw \
  -e KEYSTONE_URL='http://10.10.10.1:5000/v2.0' \
  alvaroaleman/openstack-horizon
```

## Description

A simple Openstack Horizon image, currently based on v10.0.0 (Newton).
For any advanced configuration, it is advised to build your own image
based on this using your own configuration:

```shell
FROM alvaroaleman/openstack-horizon

COPY local_settings.py /opt/horizon/openstack_dashboard/local/local_settings.py
```

## LICENSE

AGPLv3

## Author

* Alvaro Aleman
