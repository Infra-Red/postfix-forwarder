#!/bin/bash -e
j2 /templates/virtual.j2 > /etc/postfix/virtual
j2 /templates/virtual-regexp.j2 > /etc/postfix/virtual-regexp
j2 /templates/mailname.j2 > /etc/mailname
j2 /templates/main.cf.j2 >> /etc/postfix/main.cf
postmap /etc/postfix/virtual
exec "$@"
