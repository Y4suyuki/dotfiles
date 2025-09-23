#!/usr/bin/env bash
# ~/.local/bin/lsp-bridge-python
cd ~/gh/y4suyuki/lsp-bridge-python
exec nix develop -c python "$@"
