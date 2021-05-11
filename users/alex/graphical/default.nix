{ config, lib, pkgs, ... }:
{
    imports = [
        ./comms
        ./creative
        ./media
        ./utility

        ./termite.nix
    ];


    services = {
        redshift = {
            enable = true;
            provider = "geoclue2";
        };

        # Supports Keybase
        kbfs.enable = true;
        keybase.enable = true;
    };

    xresources.extraConfig = (
        lib.fileContents ./xresources.conf
    );
}