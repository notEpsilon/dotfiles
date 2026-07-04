#!/usr/bin/env bash

set -euo pipefail

rm -rf ~/.config/nvim
cp -r ./nvim ~/.config

rm -rf ~/.config/alacritty
cp -r ./alacritty ~/.config

rm -rf ~/.config/tmux
cp -r ./tmux ~/.config

rm -rf ~/.config/wezterm
cp -r ./wezterm ~/.config
