# docker-lemp-stack

## Stack
- [alpine] nginx v1.15.2
- [alpine] php-fpm(php7)
- [alpine] memcached v1.5.9
- [debian] mysql v5.7

## Get started

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
