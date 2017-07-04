#!/bin/sh

$(which docker-compose) up -d workspace caddy mysql php-fpm php-worker redis certbot
