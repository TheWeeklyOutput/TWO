#!/bin/bash

git checkout master
git pull
git submodule update

cd backend/
git pull

cd ../frontend
git pull
