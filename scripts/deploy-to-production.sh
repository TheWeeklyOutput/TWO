#!/bin/sh

ssh root@kirov.meks.io "cd /var/www/TWO; \
                        export PRODUCTION=true; \
                        make pull-master; make build; make fixtures; \
                        chown -R www-data:www-data /var/www/TWO; \
                        systemctl restart two_gunicorn.service"
