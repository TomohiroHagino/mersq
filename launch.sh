#!/bin/bash
set -e

bundle install
bundle exec puma -C config/puma.rb