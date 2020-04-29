#!/bin/bash

set -e

# default branch to current branch
branch="$(git rev-parse --abbrev-ref HEAD)"
app_name="docker-dumb-app"
if [[ "$branch" = "master" ]]; then 
    image_name="dixneuf19/$app_name:latest"
else
    image_name="dixneuf19/$app_name:$branch"
fi

# could be used for versioning
commit=$(git rev-parse --short HEAD)

echo "Releasing branch $branch for commit $commit"

echo "Building docker image"
docker build -t $image_name .

echo "Pushing to registry (need to be logged)"
docker push $image_name

echo "The $branch branch has been sucessfully released to $image_name !"