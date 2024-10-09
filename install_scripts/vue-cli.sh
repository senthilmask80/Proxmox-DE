#! /bin/bash

sudo apt install libssl-dev

# you already have what is necessary on your system to install NVM. To do this, perform the following step:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# I chose the latest LTS version, by the time I'm writing this * Gist *, it's v8.9.1. You can install it by typing:
nvm install v8.9.1

# To set a version of the node as default, run the following command:
nvm alias default 8.9.1

# Installing the vue-cli
npm install -g vue-cli --force

