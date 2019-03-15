#!/usr/bin/env bash

figlet -f standard "Build and run unit tests"

echo "Build and unit test the application"
mvn -q clean compile test