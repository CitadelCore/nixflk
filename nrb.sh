#!/bin/sh
sudo nixos-rebuild --no-write-lock-file --override-input arnix "/home/alex/src/corp/arctarus/arnix" "$@"
