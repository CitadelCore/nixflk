{ config, lib, pkgs, name, ... }:

let
    inherit (builtins) pathExists;
    my = import ./my.nix { inherit name; };
in
{
    imports = [
        ../../modules/home

        ./core
        ./develop
    ]

    ++ (if my.graphical then [./graphical] else [])

    # add host specific user configuration
    ++ (if name != null && (pathExists (./hosts + "/${name}")) then [(./hosts + "/${name}")] else []);

    # inherit the user meta configuration
    _module.args = { inherit my; };
}
