{ lib, pkgs, ... }: let
    inherit (lib.generators) toYAML;
in {
    home = {
        packages = with pkgs; [ vault vault-token-helper ];

        sessionVariables = {
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
