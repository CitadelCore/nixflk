{
    description = "My Nix flake configurations.";

    inputs = {
        # use unstable for entire system instead of nixos-20.09 until 21.05 comes out
        # because we can't have an updated gnome3 without it
        nixos.url = "github:CitadelCore/nixpkgs/nixos-unstable";
        nixpkgs.url = "github:CitadelCore/nixpkgs/nixos-unstable";
        unstable.url = "github:CitadelCore/nixpkgs/nixos-unstable";

        # arnix contains the shared base configuration
        arnix = {
            url = "github:ArctarusLimited/arnix/master";
            inputs = {
                nixos.follows = "nixos";
                nixpkgs.follows = "nixpkgs";
                unstable.follows = "unstable";

                # override home-manager to the master branch
                home.url = "github:nix-community/home-manager/master";
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
