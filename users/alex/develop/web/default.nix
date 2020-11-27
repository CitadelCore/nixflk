{ pkgs, ... }:
let
    nodePackages = with pkgs.nodePackages; [ ];
in
{
    home.packages = with pkgs; [
        nodejs-14_x
        jetbrains.webstorm
    ] ++ nodePackages;
}