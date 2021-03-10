#!/bin/sh
doas nixos-rebuild --override-input arnix "$HOME/src/corp/arctarus/arnix" "$@"
