#!/bin/sh

. /etc/apache2/envvars

APACHE_PID_FILE=/tmp/apache2.pid
APACHE_RUN_DIR=/tmp
APACHE_LOCK_DIR=/tmp
APACHE_LOG_DIR=/tmp

export APACHE_PID_FILE
export APACHE_RUN_DIR
export APACHE_LOCK_DIR
export APACHE_LOG_DIR

exec /usr/sbin/apache2 -DFOREGROUND
