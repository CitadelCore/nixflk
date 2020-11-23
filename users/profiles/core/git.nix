{ config, lib, pkgs, ... }:
{
    programs.git = {
        enable = true;
        lfs.enable = true;

        userEmail = "joseph@marsden.space";
        userName = "Alex Zero";

        extraConfig = {
            core = {
                autocrlf = "input";
            };

            http = {
                "https://teamdepot.chaosinitiative.com" = {
                    sslCert = "/home/alex/Documents/keys/chaos/public.pem";
                    sslKey = "/home/alex/Documents/keys/chaos/private.pem";
                };
            };

            #credential = {
            #    helper = "store --file ~/.gitcred";
            #};

            pull.rebase = false;
        };
    };
}
