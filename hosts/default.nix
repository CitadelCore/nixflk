{ home
, lib
, nixos
, nixpkgs
, unstable
, pkgset
, overlays
, self
, system
, utils
, ...
}:
let
    inherit (utils) recImport;
    inherit (builtins) attrValues removeAttrs;

    config = hostName: lib.nixosSystem {
        inherit system;

        modules = let
            inherit (home.nixosModules) home-manager;

            core = self.nixosModules.profiles.core;

            global = {
                networking.hostName = hostName;
                nix.nixPath = let path = toString ../.; in
                [
                    "nixpkgs=${nixpkgs}"
                    "nixos=${nixos}"
                    "nixos-config=${path}/configuration.nix"
                ];

                nixpkgs = { pkgs = pkgset.nixos; };

                nix.registry = {
                    nixos.flake = nixos;
                    nixpkgs.flake = nixpkgs;
                    nixflk.flake = self;
                };
            };
            
            overrides = {
                nixpkgs.overlays = overlays;
            };

            local = import "${toString ./.}/${hostName}.nix";

            # Everything in `./modules/list.nix`.
            flakeModules =
                attrValues (removeAttrs self.nixosModules [ "profiles" ]);

        in
            flakeModules ++ [ core global local home-manager overrides ];
    };

    hosts = recImport {
        dir = ./.;
        _import = config;
    };
in
hosts
