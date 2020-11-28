{ pkgs, ... }:
{
    home.packages = with pkgs; [
        gimp-with-plugins
        inkscape
        blender
        audacity
    ];
}