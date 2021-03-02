{ config, lib, pkgs, meta, ... }:
{
    home.packages = with pkgs.gitAndTools; [ pre-commit ];

    programs.git = {
        enable = true;
        package = lib.hiPrio pkgs.gitAndTools.gitFull;

        lfs.enable = true;

        signing = {
            key = "A51550EDB450302C";
            signByDefault = true;
        };

        userEmail = meta.email;
        userName = meta.name;

        extraConfig = {
            core = {
                autocrlf = "input";
            };

            http = {
                "https://teamdepot.chaosinitiative.com" = {
                    sslCert = "/home/${meta.username}/Documents/keys/chaos/public.pem";
                    sslKey = "/home/${meta.username}/Documents/keys/chaos/private.pem";
                };

                "https://licensees.chaosinitiative.com" = {
                    sslCert = "/home/${meta.username}/Documents/keys/chaos/public.pem";
                    sslKey = "/home/${meta.username}/Documents/keys/chaos/private.pem";
                };
            };

            credential = {
                helper = "store --file ~/.gitcred";
            };

            pull.rebase = false;
        };
    };
}
