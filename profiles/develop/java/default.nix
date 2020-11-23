{ pkgs, ... }:
{
    programs.java.enable = true;
    programs.java.package = pkgs.adoptopenjdk-hotspot-bin-8;

    environment.systemPackages = with pkgs; [
        (jetbrains.idea-community.override { jdk = jetbrains.jdk; })
    ];
}