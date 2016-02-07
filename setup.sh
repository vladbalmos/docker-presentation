#!/bin/bash

mkdir -p ~/tmp/docker-presentation/host-volume

if [ ! -d devel/wordpress-4.3 ]; then
    git clone https://github.com/vladbalmos/WordPress.git devel/wordpress-4.3
    cd devel/wordpress-4.3
    git checkout tags/4.3
    rm -rf .git
fi
