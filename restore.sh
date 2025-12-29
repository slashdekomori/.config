#!/bin/sh
set -e

cd "$HOME/.config"

if [ ! -d .git ]; then
  git init
  git remote add origin git@github.com:slashdekomori/.config.git
fi

git fetch origin
git checkout -B main origin/main
