{ lib, pkgs, ... }:
{
    home = {
        packages = with pkgs; let
            npc = nodePackagesCustom;
        in [
            # cloud providers
            awscli2 aws-sam-cli #npc.aws-cdk
            google-cloud-sdk

            # hashicorp stack
            terraform_0_14 packer vagrant
            consul consul-template
            vault boundary
            nomad waypoint

            # nix
            colmena

            # kubernetes
            calicoctl cfssl kubectl krew kubernetes-helm

            # others
            (lib.lowPrio juju)
            #python38Packages.charm-tools
        ];

        # add Krew to path for kubectl
        sessionPath = [ "\${HOME}/.krew/bin" ];
    };
}