#!/bin/bash

find ./public -mindepth 1 -regex '^./public/assets\(/.*\)?' -delete

bundle exec rake assets:precompile

rake db:create db:migrate

bundle exec puma -C config/puma.rb
