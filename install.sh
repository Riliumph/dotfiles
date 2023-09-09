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

inited_submodule()
{
  local target_path=$1
  files=("${target_path}/*")
  if (("${#files}" != 0)); then
    # echo "${target_path} is inited"
    return 0
  fi
  # echo "${target_path} is not inited"
  return 1
}

all()
{
  local func="$1"
  shift # 引数を一つズラす
  local data=("$@")
  for d in "${data[@]}"; do
    echo "checking ${d} ..."
    if ! "$func" "$d"; then
      return 1
    fi
  done
  return 0
}

root=$(abs_dirname "$0")
# echo "root is ${root}"

echo "check submodules ..."
mapfile -t dirs < <(find "${root}" -maxdepth 1 -mindepth 1 -type d \( ! -name .git -a ! -name .vscode \))
# echo "submodules: ${dirs[*]}"

if ! (all "inited_submodule" "${dirs[@]}"); then
  echo "detected noninited submodule"
  echo "init submodule ..."
  git submodule init
  git submodule update
fi

echo "install submodules"

# install bash config
cd "${root}/bash" || exit
./INSTALL.bash

# install git config

cd "${root}/git-config" || exit
./INSTALL.bash
