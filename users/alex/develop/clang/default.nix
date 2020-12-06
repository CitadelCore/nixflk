{ pkgs, ... }:
{
    home.packages = with pkgs; [
        (lib.hiPrio clang) gcc 
        jetbrains.clion
    ];
}