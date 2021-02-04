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

        packages = with pkgs; [
            # nix stuff
            nixfmt
            nix-index
            nix-prefetch
            nix-prefetch-docker
            nix-prefetch-scripts            

            # utility
            asciinema gnumake file less wget shellcheck
            diffstat diffutils findutils patch gawk

            # security
            openssl git-crypt gnupg pass mkpasswd
        ];
    };
}
