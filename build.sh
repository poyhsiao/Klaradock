#!/bin/sh
$(which docker-compose) build workspace caddy mysql php-fpm php-worker redis certbot
