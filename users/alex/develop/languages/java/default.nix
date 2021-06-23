{ pkgs, ... }:
{
    home.packages = with pkgs; [
        adoptopenjdk-hotspot-bin-16
        (jetbrains.idea-community.override { jdk = jetbrains.jdk; })
    ];
}