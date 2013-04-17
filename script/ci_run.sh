#!/usr/bin/env bash
set -e
export PATH=./bin:$PATH
bundle install --deployment --quiet --binstubs
SPEC_OPTS="--format html" bundle exec rake ci_test
