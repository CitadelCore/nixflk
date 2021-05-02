{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; let
            npc = nodePackagesCustom;
        in [
            # cloud providers
            awscli2 aws-sam-cli #npc.aws-cdk

            # hashicorp stack
            terraform_0_14 packer vagrant
            consul
            vault boundary
            nomad waypoint

            # nix
            colmena

            # kubernetes
            kubectl

            # others
            (lib.lowPrio juju)
            #python38Packages.charm-tools
        ];

        sessionVariables = {
            "HISTIGNORE" = "&:vault*";
        };
    };
}