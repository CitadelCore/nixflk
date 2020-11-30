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
    inherit (pkgset) osPkgs pkgs;

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
                    "nixos-unstable=${unstable}"
                    "nixos-config=${path}/configuration.nix"
                ];

                nixpkgs = { pkgs = osPkgs; };

                nix.registry = {
                    nixos.flake = nixos;
                    nixpkgs.flake = nixpkgs;
                    nixflk.flake = self;
                };
            };

            overrides = {
                nixpkgs.overlays = let
                    overrides = let
                        override = import ../pkgs/override.nix pkgs;

                        overlay = pkg: final: prev: {
                            "${pkg.pname}" = pkg;
                        };
                    in map overlay override;
                in overrides ++ overlays;
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
