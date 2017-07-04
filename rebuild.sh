#!/bin/sh

$(which docker-compose) build --no-cache --pull --force-rm workspace caddy mysql php-fpm php-worker redis
