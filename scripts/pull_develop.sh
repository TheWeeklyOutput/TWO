#!/bin/bash

git pull
git submodule update

cd backend/
git checkout develop
git pull

cd ../frontend
git checkout develop
git pull
