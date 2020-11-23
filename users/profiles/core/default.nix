{ lib, ... }:
{
    imports = [
        ./gnupg
        ./git.nix
        ./ssh.nix
    ];

    programs = {
        home-manager.enable = true;

        bash = {
            enable = true;
            shellAliases = {
                "lh" = "ls -lah";
                "hgrep" = "cat ~/.bash_history | grep $@";
                "drx" = "dotnet ~/src/projects/drx/DRXUtility/bin/Debug/netcoreapp3.0/DRXUtility.dll $@";
            };

            initExtra = ". \"$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh\"";
        };
    };

    home = {
        keyboard.layout = "gb";

        sessionPath = [
            "\${HOME}/src/helios/tools"
        ];

        sessionVariables = {
            "VAULT_ADDR" = "https://vault1.stir1.int.arctarus.co.uk";
            "VAULT_ARC_ROLE" = "operator";
            "VAULT_ARC_SSH_ROLE" = "operator";
        };

        stateVersion = "20.09";
    };
}
