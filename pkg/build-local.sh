#!/usr/bin/env bash
# Build and install quickbox-qt from the local git repo.
# Run from the pkg/ directory: ./build-local.sh
set -e
cd "$(dirname "$0")"
VER=$(cat ../version.txt | tr -d '[:space:]')
git -C .. archive --format=tar.gz --prefix="quickbox-qt-$VER/" HEAD \
    > "quickbox-qt-$VER.tar.gz"
makepkg -si --noconfirm
