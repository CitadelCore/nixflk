#!/bin/sh
doas nixos-rebuild --no-write-lock-file --override-input arnix "$HOME/src/corp/arctarus/arnix" "$@"
