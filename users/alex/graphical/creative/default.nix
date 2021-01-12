{ pkgs, ... }:
{
    home.packages = with pkgs; [
        libreoffice-fresh
        gimp-with-plugins
        inkscape
        blender
        audacity
    ];
}