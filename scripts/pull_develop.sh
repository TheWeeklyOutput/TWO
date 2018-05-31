#!/bin/bash

git checkout develop
git pull
git submodule update

cd backend/
git pull

cd ../frontend
git pull
