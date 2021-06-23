{ config, lib, pkgs, my, ... }: let
    inherit (lib) recursiveUpdate;
in {
    home.packages = with pkgs.gitAndTools; [ pre-commit ];

    programs.git = recursiveUpdate {
        enable = true;
        package = lib.hiPrio pkgs.gitAndTools.gitFull;

        lfs.enable = true;

        userEmail = my.email;
        userName = my.name;

        extraConfig = {
            core = {
                autocrlf = "input";
            };

            credential = {
                helper = "store --file ~/.gitcred";
            };

            pull.rebase = false;
        };
    } (lib.optionalAttrs (my.role == "personal") {
        # special options like signing and chaos HTTP should be personal only
        signing = {
            key = "A51550EDB450302C";
            signByDefault = true;
        };

        extraConfig.http = {
            "https://licensees.chaosinitiative.com" = {
                sslCert = "/home/${my.username}/Documents/keys/chaos/public.pem";
                sslKey = "/home/${my.username}/Documents/keys/chaos/private.pem";
            };
        };
    });

    programs.gh = {
        enable = true;
        gitProtocol = "ssh";
    };
}
