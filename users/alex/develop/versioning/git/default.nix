{ config, lib, pkgs, my, ... }:
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

        userEmail = my.email;
        userName = my.name;

        extraConfig = {
            core = {
                autocrlf = "input";
            };

            http = {
                "https://teamdepot.chaosinitiative.com" = {
                    sslCert = "/home/${my.username}/Documents/keys/chaos/public.pem";
                    sslKey = "/home/${my.username}/Documents/keys/chaos/private.pem";
                };

                "https://licensees.chaosinitiative.com" = {
                    sslCert = "/home/${my.username}/Documents/keys/chaos/public.pem";
                    sslKey = "/home/${my.username}/Documents/keys/chaos/private.pem";
                };
            };

            credential = {
                helper = "store --file ~/.gitcred";
            };

            pull.rebase = false;
        };
    };

    programs.gh = {
        enable = true;
        gitProtocol = "ssh";
    };
}
