#!/usr/bin/env bash

set -euo pipefail

rm -rf ~/.config/nvim
cp -r ./nvim ~/.config

rm -rf ~/.config/alacritty
cp -r ./alacritty ~/.config

rm -rf ~/.config/tmux
cp -r ./tmux ~/.config
