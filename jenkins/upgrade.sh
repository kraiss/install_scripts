#!/usr/bin/env bash

## https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+on+Ubuntu

## If you are asked to use maintainer jenkins property file,
##   refuse and keep your own file to avoid re-configuration
sudo apt-get install --only-upgrade jenkins
