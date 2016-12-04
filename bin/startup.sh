#!/bin/bash

# tells the bash script to exit whenever anything returns a non-zero return value.
set -e

bundle exec foreman start
