{ pkgs, ... }:
{
    home.packages = with pkgs; [ python3Full python38Packages.pip python38Packages.setuptools ];
}