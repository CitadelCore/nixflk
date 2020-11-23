{ pkgs, ... }:
{
    imports = [
        ./clang
        ./csharp
        ./golang
        ./java
        ./python
    ];

    environment = {
        systemPackages = with pkgs; [
            # utility
            nix-index
            git clang file less wget

            # security
            git-crypt gnupg pass mkpasswd

            # editors and IDEs
            vscode
            jetbrains.clion
        ];

        sessionVariables = {
            PAGER = "less";
            LESS = "-iFJMRWX -z-4 -x4";
            LESSOPEN = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
        };
    };

    documentation.dev.enable = true;
}