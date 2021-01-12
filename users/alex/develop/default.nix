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
            LESS = "-iFJMRWX -z-4 -x4";
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

            # version control
            git subversion mercurialFull

            # security
            openssl git-crypt gnupg pass mkpasswd
        ];
    };
}
