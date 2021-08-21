{ pkgs, ... }:
{
    home.packages = with pkgs; [
        adoptopenjdk-hotspot-bin-16
    ];
}