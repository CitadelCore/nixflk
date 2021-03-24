{ lib, ... }:
{
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

        sessionVariables = {
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
