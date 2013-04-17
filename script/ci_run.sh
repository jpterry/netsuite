#!/usr/bin/env bash
set -e
export PATH=./bin:$PATH
bundle install --quiet --binstubs --path=vendor/bundle
SPEC_OPTS="--format html" bundle exec rake ci_test
