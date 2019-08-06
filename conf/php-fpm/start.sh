#!/bin/bash

# Disable Strict Host checking for non interactive git clones
mkdir -p -m 0700 /root/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
# Start phpfpm in background
php-fpm &
# Start ssh service
/usr/sbin/sshd -D