#!/bin/sh

ssh root@kirov.meks.io 'cd /var/www/TWO; make pull; make build; chown -R www-data:www-data /var/www/TWO; systemctl restart two_gunicorn.service'
