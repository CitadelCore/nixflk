{ pkgs, ... }:
{
    home.packages = with pkgs; [
        quasselClient
        discord
        slack
    ];
}