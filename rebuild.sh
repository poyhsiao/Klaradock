#!/bin/sh
docker-compose build --no-cache --pull --force-rm workspace nginx mysql php-fpm php-worker redis jenkins certbot
