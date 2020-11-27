{ pkgs, ... }:
{
    home.packages = with pkgs; [
        clang jetbrains.clion
    ];
}