#!/bin/bash
set -e

PG_LOG=/var/log/postgresql/
PG_CONFIG=/etc/pgbouncer/pgbouncer.ini
PG_USER=postgres

mkdir -p ${PG_LOG}
chmod -R 755 ${PG_LOG}
chown -R ${PG_USER}:${PG_USER} ${PG_LOG}

echo "Starting pgbouncer as deamon..."
cd /root
nohup pgbouncer -q -u ${PG_USER} $PG_CONFIG -d
cd /var/www/html

echo "Starting apache in foreground..."
exec apache2-foreground