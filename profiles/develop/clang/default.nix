{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        clang llvm gcc
        jetbrains.clion
    ];
}