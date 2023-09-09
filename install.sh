#!/bin/bash

###
# Convert to absolute path
# @param $1 path
# @return absolute path
abs_dirname()
{
  local path="$1"

  # Check path existence one by one
  while [ -n "$path" ]; do
    # Remove the shortest pattern(/*) from right
    builtin cd "${path%/*}" || exit
    # Remove the longest pattern(*/) from left
    local name="${path##*/}"
    path="$(readlink "$name" || true)"
  done

  pwd -P # return string
}

root=$(abs_dirname "$0")
# install bash config
cd "${root}/bash" || exit
./INSTALL.bash

# install git config

cd "${root}/git-config" || exit
./INSTALL.bash
