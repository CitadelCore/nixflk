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
            terraform_0_14 terragrunt packer vagrant
            consul consul-template
            vault boundary
            nomad waypoint

            # pulumi
            pulumi-bin tf2pulumi

            # nix
            colmena

            # kubernetes
            cfssl talosctl clusterctl kubie kubectx kubectl krew kubernetes-helm operator-sdk
            vcluster calicoctl cilium-cli istioctl hubble tanka pgo-client

            # others
            (lib.lowPrio juju)
            #python38Packages.charm-tools
        ];

        # add Krew to path for kubectl
        sessionPath = [ "\${HOME}/.krew/bin" ];
    };
}