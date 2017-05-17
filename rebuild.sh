#!/bin/sh
docker-compose build --no-cache --pull --force-rm workspace nginx mysql mongo php-fpm php-worker redis jenkins certbot
