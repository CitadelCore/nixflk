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

    home = {
        sessionVariables = {
            PAGER = "less";
            LESS = "-iFJMRW -x4";
            LESSOPEN = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
        };
    };
}
