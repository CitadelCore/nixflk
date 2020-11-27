{ config, lib, pkgs, ... }:
{
    imports = [
        ./clang
        ./csharp
        ./devops
        ./golang
        ./java
        ./python
        ./web
    ];

    programs.vscode = {
        enable = true;
        userSettings = {
            workbench.colorTheme = "Visual Studio 2019 Dark";
            editor.fontLigatures = true;
        };
    };

    home = {
        sessionVariables = {
            PAGER = "less";
            LESS = "-iFJMRWX -z-4 -x4";
            LESSOPEN = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
        };

        packages = with pkgs; [
            # nix stuff
            nix-index
            nix-prefetch
            nix-prefetch-docker
            nix-prefetch-scripts            

            # utility
            gnumake file less wget

            # version control
            git p4 p4v subversion mercurialFull

            # security
            openssl git-crypt gnupg pass mkpasswd
        ];
    };
}