{ lib, pkgs, ... }: let
    inherit (lib) mapAttrsToList;
    inherit (builtins) concatStringsSep;
in {
    imports = [
        ./dconf
        ./security
        ./shell
        ./ssh
    ];

    programs = {
        home-manager.enable = true;
        command-not-found.enable = true;
    };

    xdg = {
        enable = true;
        mime.enable = true;
    };

    home = {
        keyboard.layout = "gb";

        packages = with pkgs; [ sops ];

        sessionPath = [
            "\${HOME}/src/corp/arctarus/infra/tools"
        ];

        sessionVariables = let
            # global flake override paths
            flakeOverrides = concatStringsSep ";" (mapAttrsToList (k: v: "${k}=${v}") {
                "github:ArctarusLimited/KuiserOS/master" = "$HOME/src/corp/arctarus/kuiser";
                "git+ssh://git@github.com/ArctarusLimited/infra.git?dir=nix" = "$HOME/src/corp/arctarus/infra/nix";
            });
        in {
            # setup KuiserOS repo for development
            "KUISER_REPO_PATH" = "$HOME/src/corp/arctarus/kuiser";
            "NIX_FLAKE_URL_OVERRIDES" = flakeOverrides;

            # ensure python requests uses our custom CA
            "REQUESTS_CA_BUNDLE" = "/etc/ssl/certs/ca-certificates.crt";
        };

        stateVersion = "20.09";
    };
}
