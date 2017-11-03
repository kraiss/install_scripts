#!/usr/bin/env bash

## https://docs.sonarqube.org/display/SONAR/Upgrading

sudo apt-get install --only-upgrade sonar

## If your SonarQube as custom configuration for this or the machine does not provide X
##  consider accessing this url from another workspace (http://<sonar_ip_port_and_context>/setup
sensible-browser http://localhost:9000/setup