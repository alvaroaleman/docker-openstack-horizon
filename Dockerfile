FROM debian:jessie
ENV HORIZON_BASEDIR /opt/horizon
ENV KEYSTONE_URL http://127.0.0.1:5000/v2
EXPOSE 80

RUN \
  apt update && \
  apt install -y \
    apache2 libapache2-mod-wsgi \
    python-pip python-dev git && \
    git clone https://github.com/openstack/horizon.git ${HORIZON_BASEDIR}

COPY start.sh /usr/local/bin/start.sh

RUN \
    cd ${HORIZON_BASEDIR} && \
    pip install . && \
    cp openstack_dashboard/local/local_settings.py.example openstack_dashboard/local/local_settings.py && \
    ./manage.py collectstatic --noinput && \
    ./manage.py compress --force && \
    ./manage.py make_web_conf --wsgi && \
    rm -rf /etc/apache2/sites-enabled/* && \
    ./manage.py make_web_conf --apache > /etc/apache2/sites-enabled/horizon.conf && \
    sed -i 's/<VirtualHost \*.*/<VirtualHost _default_:80>/g' /etc/apache2/sites-enabled/horizon.conf && \
    chown -R www-data:www-data ${HORIZON_BASEDIR} && \
    chmod +x /usr/local/bin/start.sh

VOLUME /var/log/apache2

CMD /usr/local/bin/start.sh
