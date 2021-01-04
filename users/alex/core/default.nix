{ lib, ... }:
{
    imports = [
        ./gnupg
        ./ssh.nix
    ];

    nixpkgs.config.allowUnfree = true;

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
            # to keep compatibility with SSH sessions and sudo as root
            "TERM" = "xterm";

            # ensure python requests uses our custom CA
            "REQUESTS_CA_BUNDLE" = "/etc/ssl/certs/ca-certificates.crt";

            # vault variables for arctarus
            "VAULT_ADDR" = "https://vault1.stir1.arctarus.net";
            "VAULT_ARC_ROLE" = "operator";
            "VAULT_ARC_SSH_ROLE" = "operator";
        };

        stateVersion = "20.09";
    };
}
