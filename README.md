# docker-lemp-stack

## Stack
- [alpine] nginx v1.15.2
- [alpine] php-fpm(php7)
- [alpine] memcached v1.5.9
- [debian] mysql v5.7

## Get started

## Note:

use '**db**' instead of locahost or 127.0.0.1 when working with mysql

```
$ git clone https://github.com/oshou/docker-lemp-stack.git
$ cd docker-lemp-stack
$ cp -rp .env.example .env
$ vim .env & specify src directory with folder 'htdocs' in it
$ docker-compose up -d
```

To stop :

```
$ docker-compose stop

```

To remove :

```
$ docker-compose down

```
To get bash shell (remember to chmod +x ./conf/bash)

```
docker exec -it docker-nginx "/bin/bash"
```
