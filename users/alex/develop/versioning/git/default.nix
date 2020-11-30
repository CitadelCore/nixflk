{ config, lib, pkgs, ... }:
{
    programs.git = {
        enable = true;
        package = lib.hiPrio pkgs.gitAndTools.gitFull;

        lfs.enable = true;

        signing = {
            key = "A51550EDB450302C";
            signByDefault = true;
        };

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
