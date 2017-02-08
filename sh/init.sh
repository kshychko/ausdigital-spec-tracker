#!/bin/bash

apt-get update && \
apt-get install -y ruby-full rubygems

gem install jekyll -y

gem install bundler -y