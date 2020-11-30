{
    description = "A highly structured configuration database.";

    inputs = {
        nixos.url = "nixpkgs/nixos-20.09";
        nixpkgs.url = "nixpkgs/release-20.09";
        unstable.url = "nixpkgs/nixos-unstable";

        home = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

      outputs = inputs@{ self, nixos, nixpkgs, unstable, home }:
    let
        inherit (builtins) attrNames attrValues readDir;
        inherit (nixos) lib;
        inherit (lib) removeSuffix recursiveUpdate genAttrs filterAttrs;
        inherit (utils) pathsToImportedAttrs;

        utils = import ./lib/utils.nix { inherit lib; };

        system = "x86_64-linux";

        # overlays are sourced from two locations:
        # pkgs/default.nix and the nix files in overlays/
        overlays = let
            overlayDir = ./overlays;
            fullPath = name: overlayDir + "/${name}";

            overlayPaths = map fullPath (attrNames (readDir overlayDir));
            packageOverlays = (attrValues (lib.filterAttrs (n: v: n != "pkgs") (
                pathsToImportedAttrs overlayPaths
            )));
        in [(import ./pkgs)] ++ packageOverlays;

        pkgImport = pkgs:
        import pkgs {
            inherit system overlays;
            config = { allowUnfree = true; };
        };

        pkgset = {
            osPkgs = pkgImport nixos;
            pkgs = pkgImport nixpkgs;
        };
    in
    with pkgset;
    {
        inherit overlays;

        nixosConfigurations = import ./hosts (recursiveUpdate inputs {
            inherit lib pkgset overlays system utils;
        });

        devShell."${system}" = import ./shell.nix {
            inherit pkgs;
        };

        packages."${system}" = lib.mkMerge (map (overlay: (overlay osPkgs osPkgs)) self.overlays);

        nixosModules =
            let
            # binary cache
            cachix = import ./cachix.nix;
            cachixAttrs = { inherit cachix; };

            # modules
            moduleList = import ./modules/list.nix;
            modulesAttrs = pathsToImportedAttrs moduleList;

            # profiles
            profilesList = import ./profiles/list.nix;
            profilesAttrs = { profiles = pathsToImportedAttrs profilesList; };

            in
            recursiveUpdate
            (recursiveUpdate cachixAttrs modulesAttrs)
            profilesAttrs;

        templates.flk.path = ./.;
        templates.flk.description = "flk template";

        defaultTemplate = self.templates.flk;
    };
}
