{ pkgs, ... }:
{
    home.packages = with pkgs; [
        go-jsonnet jsonnet-bundler
    ];
}
