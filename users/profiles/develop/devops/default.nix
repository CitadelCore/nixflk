{ pkgs, ... }:
{
    home = {
        packages = with pkgs; [
            # cloud providers
            awscli2

            # hashicorp stack
            terraform packer vagrant
            consul
            vault
            nomad
        ];

        sessionVariables = {
            "HISTIGNORE" = "&:vault*";
        };
    };
}