#!/bin/sh
doas nixos-rebuild --no-write-lock-file --override-input arnix "/home/alex/src/corp/arctarus/arnix" "$@"
