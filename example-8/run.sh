#!/bin/sh

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
