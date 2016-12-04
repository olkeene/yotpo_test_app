#!/bin/bash

bundle check || bundle install --jobs 4 --retry 5

echo "Running in app: $@"
exec "$@"
