#!/bin/bash

here=$(dirname $(realpath $0))
# echo "here: $here"
# read

if [ -z "$1" ]; then
  echo "Usage: $0 < path_to_murmurbox_directory | - >"
  echo "'-' (for test.bash directory)"
  exit 1
fi

dir=
if [ "$1" == "-" ]; then
  dir="$here"
else
  dir="$1"
fi

echo "Running murmurBOX from: $dir"
# read

DEV=1 rootmur="$dir" bash "$dir"/murmurbox.bash
