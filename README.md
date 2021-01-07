## Flake configurations

This repository contains the Nix flake configurations for my NixOS laptop. It's a heavily modified version of the original nixflk flake.

- `hosts`: Top-level definitions for each host managed by this repository.
- `lib`: Utility function library.
- `modules`: Nix modules that I have created.
- `overlays`: Package overlays for existing packages.
- `pkgs`: Nix packages that I have created.
- `profiles`: Machine-specific profiles.
- `secrets`: Secrets encrypted with git-crypt.
- `users/<user>`: User-specific profiles.
- `users/<user>/hosts/<host>`: User and machine specific profiles.

To build and switch to them, clone this repository and in `nix-shell` run `sudo nixos-rebuild switch`.