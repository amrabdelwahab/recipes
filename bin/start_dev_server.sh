#!/bin/ash

rm -f tmp/pids/server.pid
bundle exec rails server --binding 0.0.0.0