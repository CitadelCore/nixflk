#!/bin/sh
# Directly activates the home-manager configuration
# Intended for non-NixOS environments i.e. Mac or WSL
nix --experimental-features "nix-command flakes" \
    build ".#homeManagerConfigurations.$USER.activationPackage" \
    --override-input kuiser "$HOME/src/corp/arctarus/kuiser" --impure \
    && ./result/activate
