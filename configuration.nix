# this file is an impure recreation of the flake profile currently deployed
# based on the systems hostname. The purpose is so tools which do not yet have
# flake support (e.g `nixos-option`), can work as expected.
{ lib, ... }:
let
    inherit (builtins) attrNames readDir;

    hostname = lib.fileContents /etc/hostname;
    host = "/persist/nixos/hosts/${hostname}.nix";
    config =
    if (builtins.pathExists host) then
        [ host ]
    else
        [ /persist/nixos/hosts/NixOS.nix ];
in
{
    imports = (import ./modules/list.nix) ++ [
    "${
        builtins.fetchTarball
        "https://github.com/rycee/home-manager/archive/master.tar.gz"
        }/nixos"
    /persist/nixos/profiles/core.nix
    ] ++ config;

    networking.hostName = hostname;
    nix.nixPath = [
        "nixpkgs=${<nixpkgs>}"
        "nixos-config=/persist/nixos/configuration.nix"
        "nixpkgs-overlays=/persist/nixos/overlays"
    ];

    nixpkgs.overlays =
    let
        overlays = map
        (name: import (./overlays + "/${name}"))
        (attrNames (readDir ./overlays));
    in
    overlays;
}
