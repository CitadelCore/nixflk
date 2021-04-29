{ pkgs, ... }:
{
    home.packages = with pkgs; [
        quasselClient
        discord
        slack
        tdesktop # Telegram
        zoom-us
    ];
}