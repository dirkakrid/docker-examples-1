#!/bin/sh

set -x

APP_USER_ID=$(id -u)
APP_GROUP_ID=$(id -g)

NSS_WRAPPER_PASSWD=$APP_TEMPDIR/passwd
NSS_WRAPPER_GROUP=$APP_TEMPDIR/group

cat /etc/passwd > $NSS_WRAPPER_PASSWD
cat /etc/group > $NSS_WRAPPER_GROUP

echo "www-user:x:$APP_USER_ID:$APP_GROUP_ID:www-user:/var/www:/sbin/nologin" >> $NSS_WRAPPER_PASSWD
echo "www-user:x:$APP_GROUP_ID:" >> $NSS_WRAPPER_GROUP

if [ x"$APP_USER_ID" != x"0" ]; then
    export NSS_WRAPPER_PASSWD
    export NSS_WRAPPER_GROUP

    LD_PRELOAD=/usr/local/nss_wrapper/lib64/libnss_wrapper.so
    export LD_PRELOAD
fi

whoami

SERVER_ARGS=""

SERVER_ARGS="$SERVER_ARGS --log-to-terminal"
SERVER_ARGS="$SERVER_ARGS --working-directory example"
SERVER_ARGS="$SERVER_ARGS --url-alias /static example/htdocs"
SERVER_ARGS="$SERVER_ARGS --application-type module example.wsgi"

MOD_WSGI_PROCESSES=${MOD_WSGI_PROCESSES:-5}
MOD_WSGI_THREADS=${MOD_WSGI_THREADS:-3}

SERVER_ARGS="$SERVER_ARGS --processes $MOD_WSGI_PROCESSES"
SERVER_ARGS="$SERVER_ARGS --threads $MOD_WSGI_THREADS"

if test x"$MOD_WSGI_RELOAD_ON_CHANGES" != x""; then
    SERVER_ARGS="$SERVER_ARGS --reload-on-changes"
fi

exec mod_wsgi-express start-server ${SERVER_ARGS}
