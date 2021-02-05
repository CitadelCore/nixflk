{ pkgs, ... }:
{
    imports = [ ./git ];

    home.packages = with pkgs; [
        p4 p4v subversion mercurialFull
    ];
}