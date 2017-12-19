#!/usr/bin/env bash

## Install Java 8
sudo apt-get install python-software-properties
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java9-installer

## Install Maven 3
sudo apt-get purge maven maven2 maven3
sudo add-apt-repository ppa:andrei-pozolotin/maven3
sudo apt-get update
sudo apt-get install maven3

## Install NPM
sudo apt-get update
sudo apt-get install nodejs
sudo apt-get install npm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
  ## RESTART TERM
nvm --version
nvm install node ## Or for lts version 'nvm install --lts'
nvm listcl

## Install Latest Mongo
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list && sudo apt-get update
sudo apt-get install -y --allow-unauthenticated mongodb-org

