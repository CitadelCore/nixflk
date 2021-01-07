{ config, lib, pkgs, ... }:
{
    imports = [
        ./comms
        ./creative
        ./media
        ./utility

        ./termite.nix
    ];

    services.redshift = {
        enable = true;
        provider = "geoclue2";
    };

    xresources.extraConfig = (
        lib.fileContents ./xresources.conf
    );
}