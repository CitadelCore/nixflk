{ config, lib, pkgs, host, ... }:

let
    inherit (builtins) pathExists;
    my = import ./my.nix { inherit host; };
in
{
    imports = [
        ../../modules/home

        ./core
        ./develop
    ]

    ++ (if my.graphical then [./graphical] else [])

    # add host specific user configuration
    ++ (if host != null && (pathExists (./hosts + "/${host}")) then [(./hosts + "/${host}")] else []);

    # inherit the user meta configuration
    _module.args = { inherit my; };
}
