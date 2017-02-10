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

# install memcached
RUN         apt-get update \
            && apt-get install -y \
                pkg-config \
                libmemcached-dev \
            && printf "\n" | pecl install memcached

# enable some php modules
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
                xdebug \
                memcached

ADD         entrypoint.sh /usr/local/bin/

ENTRYPOINT  ["/usr/local/bin/entrypoint.sh"]
