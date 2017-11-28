#!/usr/bin/env bash

## https://docs.sonarqube.org/display/SONAR/Upgrading

## If you are asked to use maintainer jenkins property file,
##   refuse and keep your own file to avoid re-configuration (usually 'N')
sudo apt-get install --only-upgrade sonar
sudo service sonar restart

## If the machine does not provide X consider accessing this url from 
##   another workspace (http://<sonar_ip_port_and_context>/setup
sensible-browser http://localhost:9000/setup
