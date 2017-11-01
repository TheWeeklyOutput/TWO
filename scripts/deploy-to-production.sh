#!/bin/sh

ssh root@kirov.meks.io 'cd /var/www/TWO; make pull; make build; chown www-data:www-data /var/www/TWO; systemctl restart tapthat_gunicorn.service'
