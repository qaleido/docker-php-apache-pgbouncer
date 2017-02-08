# Latest
FROM        tetraweb/php:5.3-apache
MAINTAINER  Kotaimen <kotaimen.c@gmail.com>

ENV         DEBIAN_FRONTEND noninteractive

# Old pgbouncer install where the DNS hostname aliases of docker(-compose) didn't work because of the
#RUN         set -x \
#            && apt-get -qq update \
#            && apt-get install -yq --no-install-recommends pgbouncer \
#            && apt-get purge -y --auto-remove \
#            && rm -rf /var/lib/apt/lists/*

RUN         apt-get update \
            && apt-get -y --no-install-recommends install \
                automake \
                build-essential \
                ca-certificates \
                git \
                libc-ares2 \
                libc-ares-dev \
                libev4 \
                libev-dev \
                libevent-2.0-5 \
                libevent-dev \
                libssl1.0.0 \
                libssl-dev \
                libtool \
                pkg-config \
                wget \
            && mkdir -p /opt && cd /opt \
            && git clone https://github.com/pgbouncer/pgbouncer.git \
            && cd /opt/pgbouncer \
            && git checkout pgbouncer_1_7_2 \
            && git submodule init \
            && git submodule update \
            && ./autogen.sh \
            && ./configure --enable-evdns=no \
            && make \
            && make install \
            && apt-get remove -y \
                automake \
                build-essential \
                ca-certificates \
                git \
                libc-ares-dev \
                libev-dev \
                libevent-dev \
                libssl-dev \
                libtool \
                pkg-config \
                wget \
            && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN         mkdir -p /etc/pgbouncer/ \
            && mkdir -p /var/run/postgresql/ \
            && groupadd --system postgres \
            && useradd -g postgres postgres \
            && mkdir -p /var/log/postgresql/ \
            && chown postgres:postgres /var/log/postgresql/ \
            && chown postgres:postgres /var/run/postgresql/

# Allready done in https://github.com/TetraWeb/docker/blob/master/php/5.3/apache/Dockerfile
#ENV         XDEBUG_VERSION 2.2.7
#
#RUN         apt-get update && apt-get install -y ca-certificates
#
## Install php extensions
#RUN         buildDeps=" \
#                freetds-dev \
#                libbz2-dev \
#                libc-client-dev \
#                libenchant-dev \
#                libfreetype6-dev \
#                libgmp3-dev \
#                libicu-dev \
#                libjpeg62-dev \
#                libkrb5-dev \
#                libldap2-dev \
#                libmcrypt-dev \
#                libmysql++-dev \
#                libmysqlclient-dev \
#                libpng12-dev \
#                libpq-dev \
#                libpspell-dev \
#                libsasl2-dev \
#                libsnmp-dev \
#                libssl-dev \
#                libtidy-dev \
#                libxml2-dev \
#                libxpm-dev \
#                libxslt1-dev \
#                zlib1g-dev \
#            " \
#            && phpModules=" \
#                bcmath bz2 calendar dba enchant exif ftp gd gettext gmp imap intl ldap mbstring mcrypt mssql mysql mysqli pcntl pdo pdo_dblib pdo_mysql pdo_pgsql pgsql pspell shmop snmp soap sockets sysvmsg sysvsem sysvshm tidy wddx xmlrpc xsl zip xdebug \
#            " \
#            && echo "deb http://httpredir.debian.org/debian jessie contrib non-free" > /etc/apt/sources.list.d/additional.list \
#            && apt-get update && apt-get install -y libc-client2007e libenchant1c2a libfreetype6 libicu48 libjpeg62 libmcrypt4 libmysqlclient18 libpng12-0 libpq5 libsybdb5 libtidy-0.99-0 libx11-6 libxpm4 libxslt1.1 snmp --no-install-recommends \
#            && apt-get install -y $buildDeps --no-install-recommends \
#            && cd /usr/src/php/ext/ \
#            && curl -L https://xdebug.org/files/xdebug-$XDEBUG_VERSION.tgz | tar -zxf - \
#            && mv xdebug-$XDEBUG_VERSION xdebug \
#        #    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
##            && ln -s /usr/lib/x86_64-linux-gnu/libldap_r.so /usr/lib/libldap.so \
##            && ln -s /usr/lib/x86_64-linux-gnu/libldap_r.a /usr/lib/libldap_r.a \
##            && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.a /usr/lib/libsybdb.a \
##            && ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/libsybdb.so \
##            && ln -s /usr/lib/x86_64-linux-gnu/libXpm.a /usr/lib/libXpm.a \
##            && ln -s /usr/lib/x86_64-linux-gnu/libXpm.so /usr/lib/libXpm.so \
#            && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-xpm-dir=/usr/include/ \
#            && docker-php-ext-configure imap --with-imap --with-kerberos --with-imap-ssl \
#            && docker-php-ext-configure ldap --with-ldap-sasl \
#            && docker-php-ext-install $phpModules \
##            && printf "\n" | pecl install mongo \
#        #    && pecl install mongodb \
##            && pecl install redis-2.2.8 \
#            && for ext in $phpModules; do \
#                   rm -f /usr/local/etc/php/conf.d/docker-php-ext-$ext.ini; \
#               done \
#            && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false $buildDeps
#
## Install additional packages
#RUN         apt-get update && apt-get install -y git msmtp-mta openssh-client --no-install-recommends && rm -r /var/lib/apt/lists/*
#
### Install composer and put binary into $PATH
##RUN     curl -sS https://getcomposer.org/installer | php \
##        && mv composer.phar /usr/local/bin/ \
##        && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

RUN         docker-php-ext-enable \
                pdo_pgsql \
                pdo_mysql \
                mcrypt \
                mbstring \
                imap \
                xmlrpc \
#                memcache \
#                redis \
                gd \
                calendar \
                soap \
                sockets \
                xdebug

ADD         entrypoint.sh /usr/local/bin/

ENTRYPOINT  ["/usr/local/bin/entrypoint.sh"]
