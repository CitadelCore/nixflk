{ pkgs, ... }:
{
    home.packages = with pkgs; [
        discord
        quasselClient
        slack
        tdesktop # Telegram
        zoom-us
        keybase-gui
    ];
}