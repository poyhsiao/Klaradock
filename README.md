# KlaraDock

This is a side project which is modified from original [laraDock] project.

We'd like to modify something to better work for my self development of web services. But don't want to change the pure and clean of the original [laraDock] project.

## Basic document
All the original document(README) of [laraDock] can be found:

- [English version](http://laradock.io/)
- [中文版 (舊版-未更新)](README-zh.md)

## Basic environment

For easier development of laravel and manage MySQL (default DB server). I build up two laravel environment folder and one [phpMyAdmin] folder which are above this KlaraDock folder.

  ../n20/:/var/www/n20
  ../front:/var/www/front
  ../myadm:/var/www/myadm

If you want to set it by yourself, please update .env file, which you can copy the file setting from env-example, set its settings ***APPLICATION*** and ***POINTER1***, ***POINTER2***, and ***POINTER3*** settings

Also, you need to update the settings for web servers.

For caddy:

- caddy/Caddyfile

For nginx:

- nginx/nginx.conf
- nginx/sites/n20.dev.conf
- nginx/sites/front.dev.conf
- nginx/sites/myadm.dev.conf
  
and, these folder is mapping to the the sites ***n20.dev*** , ***front.dev*** and ***myadm.dev***

To make sure these sites work properitily, ***MAKE SURE*** modify your ***/etc/hosts*** setting as below

  127.0.0.1 n20.dev front.dev myadm.dev
  
Of course, you may change these settings as well. Just modify [docker-compose.yml](docker-compose.yml), [sites setting](nginx/sites) and ***/etc/hosts*** setting.

## Update 2017/05/17

reference version: *[laradock] project: [b2ad5f1](https://github.com/laradock/laradock/commit/b2ad5f16e8e82fd5f1f9364ba9b26b85df212c7f)*

We have a huge update since last update. Since this version, we will try to follow the official project [laradock], since the official project [laradock] is well-developed project. We just add some features that we need for some reasons.

The follow list is our current changes.

1. Default support multiple sites with this single docker-compose set.
1. For better compatiable with [laravel] development, change [nodejs] version 6 instead of stable.
1. Add [imagemagick] with **webp** support on both workspace and php-fpm (also should set the items at .env file).
1. Since I am in Taiwan, change the time zone to Asia/Taipei instead of UTC.
1. Update .gitignore that will ignore .env* which will better for users set its settings in various environment (ex. .env-production for production environment and .env-develop for development)
1. Update default username / password
1. Add some short commands ([start.sh](start.sh) / [shutdown.sh](shutdown.sh) / [restart.sh](restart.sh) / [service.sh](service.sh)) for beginner start / stop / restart docker services and login docker environemnt with service.sh
1. Fix default caddy site settings for compatiable latest [laravel] version (5.4).
1. Use caddy as default web server and use https by default (if connect with http, will auto-redirect to https, REMEMBER to update your [laravle] .env settings).
1. Add some MongoDB php settings that fix *Fatal error: Class 'MongoDB\Driver\Manager' not found* issue in some situation.
1. Turn up the memory limit of php-fpm

Exception description above, you may reference the [laradock official website] for detail settings.

## Changes

Here are some changes that is quite different from the original [laraDock] project.

1. Default assume we use multiple web site.
2. For better compatiable with [laravel] development, change [nodejs] version as 6 instead of stable since we cannot use LTS version in nvm.
3. Add [imagemagick] and [graphicsmagick] for some reason when convert some image format requirement.
4. Since I am in Taiwan, change the time zone to Asia/Taipei instead of UTC.
5. Link all storage to storage folder for better update / rebuild / migration requirement.
6. Set default environment switch for laravel development, just turn something on or off.
7. Make sure nginx site settings link to its sites folder instead of copy these settings at build time.
8. Set default username / password as very silly names.
9. Add some short commands ([start.sh](start.sh) / [shutdown.sh](shutdown.sh) / [restart.sh](restart.sh) / [service.sh](service.sh)) for beginner start / stop / restart docker services and login docker environemnt with service.sh
10. Turn-off all php-fpm / hhvm expose php info.
11. Upgrade mysql to 5.7
12. Add exif / bz2 / intl / imagemagick php extension.
13. Turn up the memory limit of php-fpm.

***really thanks [laradock] project***

[laradock]: https://github.com/LaraDock/laradock (laraDock)
[laravel official website]: http://laradock.io (laradock.io)
[laravel]: https://laravel.com (laravel)
[nodejs]: https://nodejs.org (node.js)
[imagemagick]: https://www.imagemagick.org/ (imagemagick)
[graphicsmagick]: http://www.graphicsmagick.org/ (graphicsmagick)
