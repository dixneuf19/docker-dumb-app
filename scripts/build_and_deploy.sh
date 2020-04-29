#!/bin/bash

set -e

# default branch to master
branch=${1:-master}
app_name="docker-dumb-app"
image_name="dixneuf19/$app_name:$branch"

echo "Deploying branch $branch"

echo "Pull from repo"
rm -rf "./$app_name"
git clone -b "$branch" "https://github.com/dixneuf19/$app_name.git"

echo "Building docker image"
cd ./docker-dumb-app
docker build -t "$image_name" .
cd ..

docker stop $app_name && echo "Stopping current run" || echo "Nothing is running"

echo "Launching new build"
docker run -d --rm -p 3000:8080 --name "$app_name" "$image_name"

echo "The $branch branch has been sucessfully deployed for $app_name !"