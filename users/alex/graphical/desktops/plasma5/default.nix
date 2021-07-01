{ pkgs, ... }:
{
    home.packages = (with pkgs; [
        qvtf
    ]) ++ (with pkgs.libsForQt5; [
        gwenview
        yakuake
    ]);

    services.kdeconnect = {
        enable = true;
        indicator = true;
    };
}