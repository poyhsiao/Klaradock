#!/bin/sh

$(which docker-compose) build --no-cache --pull --force-rm workspace caddy mariadb php-fpm php-worker redis
