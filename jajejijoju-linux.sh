#!/bin/sh
echo -ne '\033c\033]0;JaJeJiJoJu\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/jajejijoju-linux.x86_64" "$@"
