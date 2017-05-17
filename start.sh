#!/bin/sh
$(which docker-compose) up -d workspace caddy mysql mongo php-fpm php-worker redis jenkins certbot
