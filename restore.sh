#!/bin/sh
set -e

cd "$HOME/.config"

if [ ! -d .git ]; then
  git init
fi

if ! git remote | grep -q '^origin$'; then
  git remote add origin git@github.com:slashdekomori/.config.git
fi

git fetch origin

# Backup only tracked files
BACKUP_DIR="$HOME/.config.backup.$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

git ls-tree -r --name-only origin/main | while read -r path; do
  if [ -e "$path" ]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$path")"
    mv "$path" "$BACKUP_DIR/$path"
  fi
done

git checkout -B main origin/main
