#!/bin/bash

# exit when any command fails
set -e

# default branch to current branch
branch=${1:master}
app_name="docker-dumb-app"

if [[ "$branch" = "master" ]]; then 
    image_name="dixneuf19/$app_name:latest"
else
    image_name="dixneuf19/$app_name:$branch"
fi

echo "Pulling $image_name from registry"
docker pull $image_name

docker stop $app_name && echo "Stopping current run" || echo "Nothing is running"

echo "Launching new build"
docker run -d --rm -p 3000:8080 --name $app_name $image_name

echo "The $branch branch has been sucessfully deployed from $image_name !"