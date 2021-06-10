{ config, lib, pkgs, ... }:
{
    imports = [
        ./devops
        ./languages
        ./network
        ./tools
        ./versioning
        ./web
    ];
}
