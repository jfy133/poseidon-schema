#!/bin/bash

# find and list all errors
find . -iname "*.json" -type f -exec jsonlint-php "{}" \;

# fail 
find . -iname "*.json" -type f -exec sh -c 'for n; do jsonlint-php "$n" > /dev/null || exit 1; done' sh {} +

