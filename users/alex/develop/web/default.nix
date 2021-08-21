{ pkgs, ... }:
let
    nodePackages = with pkgs.nodePackages; [ ];
in
{
    home.packages = with pkgs; [
        postman
        nodejs-14_x
    ] ++ nodePackages;
}