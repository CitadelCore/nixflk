{ pkgs, ... }:
{
    environment = {
        systemPackages = with pkgs; [
            # utility
            nix-index file less wget

            # version control
            git p4 p4v subversion mercurialFull

            # security
            git-crypt gnupg pass mkpasswd
        ];

        sessionVariables = {
            PAGER = "less";
            LESS = "-iFJMRWX -z-4 -x4";
            LESSOPEN = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
        };
    };

    documentation.dev.enable = true;
}