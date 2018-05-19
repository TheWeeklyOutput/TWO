#!/bin/bash

make management "crawl --date $(date "+%Y-%m") --amount-per-category 200"
