#!/usr/bin/env bash

## http://sonar-pkg.sourceforge.net/
sudo echo "deb http://downloads.sourceforge.net/project/sonar-pkg/deb binary/" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install sonar