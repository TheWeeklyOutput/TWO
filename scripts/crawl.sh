#!/bin/bash

cd /var/www/TWO && make management "crawl --date $(date "+%Y-%m") --amount-per-category 200"
