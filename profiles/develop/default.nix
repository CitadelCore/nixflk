{ pkgs, ... }:
{
    environment = {
        systemPackages = with pkgs; [
            # utility
            clang file less wget

            # security
            git-crypt gnupg pass mkpasswd

            # editors
            vscode
        ];

        sessionVariables = {
            PAGER = "less";
            LESS = "-iFJMRWX -z-4 -x4";
            LESSOPEN = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
        };
    };

    documentation.dev.enable = true;

    programs.mtr.enable = true;
}