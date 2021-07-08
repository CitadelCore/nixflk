{
    description = "My Nix flake configurations.";

    inputs = {
        # use custom repo for secure boot + iptables fixes
        nixos.url = "nixpkgs/release-21.05";
        nixpkgs.url = "nixpkgs/release-21.05";
        unstable.url = "github:ArctarusLimited/nixpkgs";

        # arnix contains the shared base configuration
        arnix = {
            url = "github:ArctarusLimited/arnix/master";
            inputs = {
                nixos.follows = "nixos";
                nixpkgs.follows = "nixpkgs";
                unstable.follows = "unstable";
            };
        };

        # additional imports
        sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ arnix, ... }: let
        inherit (arnix) lib;
    in lib.mkArnixRepo {
        inherit inputs;
        parent = arnix;
        name = "toplevel";
        root = ./.;
    };
}
