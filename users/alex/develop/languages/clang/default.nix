{ pkgs, ... }:
{
    home.packages = with pkgs; [
        (lib.hiPrio clang) lldb gcc
        jetbrains.clion
    ];
}