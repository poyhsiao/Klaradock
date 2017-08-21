#!/bin/sh
$(which docker-compose) build workspace caddy mariadb php-fpm php-worker redis
