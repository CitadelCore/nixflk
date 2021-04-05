{ lib, ... }: let
    inherit (lib) mapAttrsToList;
    inherit (builtins) concatStringsSep;
in {
    imports = [
        ./dconf
        ./gnupg
        ./shell
        ./ssh
    ];

    #nixpkgs.config.allowUnfree = true;
    
    programs = {
        home-manager.enable = true;
        command-not-found.enable = true;
    };

    xdg = {
        enable = true;
        mime.enable = true;
    };

    home = {
        keyboard.layout = "gb";

        sessionPath = [
            "\${HOME}/src/corp/arctarus/infra/tools"
        ];

        sessionVariables = let
            # global flake override paths
            flakeOverrides = concatStringsSep ";" (mapAttrsToList (k: v: "${k}=${v}") {
                "github:ArctarusLimited/arnix/master" = "$HOME/src/corp/arctarus/arnix";
                "git+ssh://git@github.com/ArctarusLimited/infra.git" = "$HOME/src/corp/arctarus/infra";
            });
        in {
            # setup arnix repo for development
            "ARNIX_REPO_PATH" = "$HOME/src/corp/arctarus/arnix";
            "NIX_FLAKE_URL_OVERRIDES" = flakeOverrides;

            # ensure python requests uses our custom CA
            "REQUESTS_CA_BUNDLE" = "/etc/ssl/certs/ca-certificates.crt";

            # use the correct SSH auth socket
            "SSH_AUTH_SOCK" = "/run/user/$UID/gnupg/S.gpg-agent.ssh";

            # vault variables for arctarus
            "VAULT_ADDR" = "https://vault1.stir1.arctarus.net";
            "VAULT_ARC_ROLE" = "operator";
            "VAULT_ARC_SSH_ROLE" = "operator";
        };

        stateVersion = "20.09";
    };
}
