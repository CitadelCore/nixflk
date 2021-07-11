{ pkgs, ... }:
{
    home.packages = (with pkgs; [
        qvtf
    ]) ++ (with pkgs.libsForQt5; [
        gwenview
        kamoso
        yakuake
    ]);

    services.kdeconnect = {
        enable = true;
        indicator = true;
    };
}