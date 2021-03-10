{
    description = "My Nix flake configurations.";

    inputs = {
        # use unstable for entire system instead of nixos-20.09 until 21.05 comes out
        # because we can't have an updated gnome3 without it
        nixos.url = "github:CitadelCore/nixpkgs/nixos-unstable";
        nixpkgs.url = "github:CitadelCore/nixpkgs/nixos-unstable";
        unstable.url = "github:CitadelCore/nixpkgs/nixos-unstable";

        nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        home = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # arnix contains the shared base configuration
        arnix = {
            url = "github:ArctarusLimited/arnix/master";
            inputs = {
                nixos.follows = "nixos";
                nixpkgs.follows = "nixpkgs";
                unstable.follows = "unstable";
                nixos-hardware.follows = "nixos-hardware";
            };
        };
    };

    outputs = inputs@{ arnix, ... }: let
        inherit (arnix) lib;
    in lib.mkTopLevelArnixRepo ./. arnix inputs;
}
