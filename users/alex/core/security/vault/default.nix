{ lib, pkgs, ... }: let
    inherit (lib.generators) toYAML;
in {
    home = {
        packages = with pkgs; [ vault vault-token-helper ];

        sessionVariables = {
            # vault variables for arctarus
            "VAULT_ADDR" = "https://vault.default.k8s.stir1.arctarus.net:8200";
            "VAULT_CACERT" = "$HOME/src/corp/arctarus/infra/nix/profiles/vault/client/server.pem";
            "VAULT_ARC_ROLE" = "operator";
            "VAULT_ARC_SSH_ROLE" = "operator";

            # vault production hardening
            "HISTIGNORE" = "&:vault*:vault-token-helper*";
        };

        file = {
            # configure Vault Client
            ".vault".text = ''
                token_helper = "${pkgs.vault-token-helper}/bin/vault-token-helper"
            '';

            ".vault-token-helper.yaml".text = toYAML {} {
                backend = "pass";
            };
        };
    };
}
