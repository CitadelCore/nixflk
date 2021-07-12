{
    description = "My Nix flake configurations.";

    inputs = {
        # use custom repo for secure boot + iptables fixes
        nixos.url = "nixpkgs/release-21.05";
        nixpkgs.url = "nixpkgs/release-21.05";
        unstable.url = "github:ArctarusLimited/nixpkgs";

        # KuiserOS contains the shared base configuration
        kuiser = {
            url = "github:ArctarusLimited/KuiserOS/master";
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

    outputs = inputs@{ kuiser, ... }: let
        inherit (kuiser) lib;
    in lib.mkRepo {
        inherit inputs;
        parent = kuiser;
        name = "toplevel";
        root = ./.;
    };
}
