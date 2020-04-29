#!/bin/bash

# default branch to current branch
branch=${1:-$(git rev-parse --abbrev-ref HEAD)}
commit=$(git rev-parse --short HEAD)


image_name=dixneuf19/docker-dumb-app:$branch

echo "Releasing branch $branch for commit $commit"

echo "Building docker image"
docker build -t image $image_name .

echo "Pushing to registry (need to be logged)"
docker push $image_name

echo "The $branch branch has been sucessfully released to $image_name !"