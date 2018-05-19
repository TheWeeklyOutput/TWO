#!/bin/bash

git pull
git submodule update

cd backend/
git checkout master
git pull

cd ../frontend
git checkout master
git pull
