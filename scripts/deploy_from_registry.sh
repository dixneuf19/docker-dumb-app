#!/bin/bash

# default branch to current branch
branch=${1:master}

image_name=dixneuf19/docker-dumb-app:$branch

echo "Pulling $image_name from registry (need to be logged)"
docker pull $image_name

echo "Stopping current run"
docker stop docker-dumb-app

echo "Launching new build"
docker run -d --rm -p 3000:8080 --name docker-dumb-app docker-dumb-app:$branch

echo "The $branch branch has been sucessfully deployed from $image_name !"