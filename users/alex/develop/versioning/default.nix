{ pkgs, ... }:
{
    imports = [ ./git ];

    home.packages = with pkgs; [
        subversion mercurialFull
    ];
}