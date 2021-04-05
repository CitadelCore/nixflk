{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; let
            npc = nodePackagesCustom;
        in [
            # cloud providers
            awscli2 aws-sam-cli #npc.aws-cdk

            # hashicorp stack
            terraform packer vagrant
            consul
            vault boundary
            nomad waypoint

            # nix
            colmena

            # others
            (lib.lowPrio juju)
            #python38Packages.charm-tools
        ];

        sessionVariables = {
            "HISTIGNORE" = "&:vault*";
        };
    };
}