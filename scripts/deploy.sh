#!/bin/bash

# default branch to master
branch=${1:-master}

echo "Deploying branch $branch"

echo "Pull from repo"
rm -rf ./docker-dumb-app
git clone -b "$branch" https://github.com/dixneuf19/docker-dumb-app.git

echo "Building docker image"
cd ./docker-dumb-app
docker build -t docker-dumb-app:$branch .
cd ..

echo "Stopping current run"
docker stop docker-dumb-app

echo "Launching new build"
docker run --rm -p 3000:8080 --name docker-dumb-app docker-dumb-app:$branch