{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        quasselClient
        discord
        slack
    ];
}