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
4. If error with mysql, remove all container and volume then restart docker:
```
docker rm -f $(docker ps -a -q)
docker volume rm $(docker volume ls -q)
```
5. nano .env & specify src directory = 'www' (with folder 'htdocs' in www)
## Get started



```
$ git clone https://github.com/ganuonglachanh/docker-lemp-stack.git
$ cd docker-lemp-stack
$ cp -rp .env.example .env
$ docker-compose up -d
```
Your home in **./www/htdocs**

## Xdebug

```
Change Xdebug Port in phpStorm to 9001
```

To connect ssh to docker-php7fpm (username = root password = root) :

```
$ ssh root@127.0.0.1 -p 2222
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
