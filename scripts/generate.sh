#!/bin/bash

cd /var/www/TWO && make management "generate --active-categories True --amount 10"
cd /var/www/TWO && make ping-google
