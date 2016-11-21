# KlaraDock

----

This is a side project which is modified from original [laraDock] project.

We'd like to modify something to better work for my self development of web services. But don't want to change the pure and clean of the original [laraDock] project.

## Basic document
All the original document(README) of [laraDock] can be found:

- [English version](laravel-README.md)
- [Chinese version](laravel-README-zh.md)

## Basic environment

For easier development of laravel and manage mysql (default DB server). I build up two laravel environment folder and one [phpMyAdmin] folder which are above this KlaraDock folder.

	../n20/:/var/www/n20
	../front:/var/www/front
	../myadm:/var/www/myadm

These folders are set at ***docker-compose.yml*** and the default website settings are locate at ***nginx/sites/***
	
	n20.dev.conf
	front.dev.conf
	myadm.dev.conf
	
and, these folder is mapping to the the sites ***n20.dev*** , ***front.dev*** and ***myadm.dev***

To make sure these sites work properitily, ***MAKE SURE*** modify your ***/etc/hosts*** setting as below

	127.0.0.1 n20.dev front.dev myadm.dev
	
Of course, you may change these settings as well. Just modify [docker-compose.yml](docker-compose.yml), [sites setting](nginx/sites) and ***/etc/hosts*** setting.

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

[laradock]: https://github.com/LaraDock/laradock (laraDock)
[laravel]: https://laravel.com (laravel)
[nodejs]: https://nodejs.org (node.js)
[imagemagick]: https://www.imagemagick.org/ (imagemagick)
[graphicsmagick]: http://www.graphicsmagick.org/ (graphicsmagick)