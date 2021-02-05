{ pkgs, ... }:
{
    home.packages = with pkgs; [
        enigma
        multimc
        (wesnoth.override { enableTools = true; })
        (warzone2100.override { withVideos = true; })
    ];
}