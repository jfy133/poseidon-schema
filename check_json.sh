#!/bin/bash
find . -iname "*.json" -type f -exec jsonlint-php "{}" \;
