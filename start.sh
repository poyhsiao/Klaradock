#!/bin/sh

$(which docker-compose) up -d workspace caddy mariadb php-fpm php-worker redis
