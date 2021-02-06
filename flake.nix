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
    };

      outputs = inputs@{ self, nixos, nixpkgs, unstable, nixos-hardware, home }:
    let
        inherit (builtins) attrNames attrValues readDir;
        inherit (nixos) lib;

        utils = import ./lib/utils.nix { inherit lib; };

        system = "x86_64-linux";

        # uses override.nix to override packages to their unstable variants
        packageOverrides = final: prev: import ./pkgs/override.nix (import unstable {
            inherit system;
            allowUnfree = true;
        });

        # overlays are sourced from two locations:
        # pkgs/default.nix and the nix files in overlays/
        overlays = let
            overlayDir = ./overlays;
            fullPath = name: overlayDir + "/${name}";

            overlayPaths = map fullPath (attrNames (readDir overlayDir));
            packageOverlays = (attrValues (lib.filterAttrs (n: v: n != "pkgs") (
                utils.pathsToImportedAttrs overlayPaths
            )));
        in [(import ./pkgs) packageOverrides] ++ packageOverlays;

        pkgImport = pkgs: import pkgs {
            inherit system overlays;
            config = { allowUnfree = true; };
        };

        pkgset = {
            nixos = pkgImport nixos;
            nixpkgs = pkgImport nixpkgs;
            unstable = pkgImport unstable;
        };
    in
    {
        inherit overlays;

        nixosConfigurations = import ./hosts (lib.recursiveUpdate inputs {
            inherit lib overlays system utils pkgset;
        });

        devShell."${system}" = import ./shell.nix { pkgs = pkgset.nixpkgs; };

        packages."${system}" = with pkgset; lib.mkMerge (map (overlay: (overlay nixpkgs nixpkgs)) self.overlays);

        nixosModules =
            let
            # binary cache
            cachix = import ./cachix.nix;
            cachixAttrs = { inherit cachix; };

            # modules
            moduleList = import ./modules/list.nix;
            modulesAttrs = utils.pathsToImportedAttrs moduleList;

            # profiles
            profilesList = import ./profiles/list.nix;
            profilesAttrs = { profiles = utils.pathsToImportedAttrs profilesList; };

            in
            lib.recursiveUpdate
            (lib.recursiveUpdate cachixAttrs modulesAttrs)
            profilesAttrs;

        templates.flk.path = ./.;
        templates.flk.description = "flk template";

        defaultTemplate = self.templates.flk;
    };
}
