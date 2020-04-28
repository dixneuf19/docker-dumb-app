#!/bin/bash

# install docker if necessary

if [ command -v docker >/dev/null ]; then
    echo "installing docker"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh

    # add current user to docker group
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker

    # clean up
    rm -f get-docker.sh
fi