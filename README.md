# docker-lemp-stack

## Stack
- [alpine] nginx v1.15.2
- [alpine] php-fpm(php7)
- [alpine] memcached v1.5.9
- [debian] mysql v5.7

## Note:
1. use '**db**' instead of locahost or 127.0.0.1 when working with mysql
2. phpMyAdmin: http://127.0.0.1:8888/
3. server stats: http://127.0.0.1:19999/
## Get started



```
$ git clone https://github.com/ganuonglachanh/docker-lemp-stack.git
$ cd docker-lemp-stack
$ cp -rp .env.example .env
$ mkdir www
$ cd www
$ mkdir htdocs
$ vim .env & specify src directory = 'www' (with folder 'htdocs' in www)
$ docker-compose up -d
```
Your home in **./www/htdocs**

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
