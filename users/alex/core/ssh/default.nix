{ config, lib, pkgs, ... }: let
    inherit (lib) recursiveUpdate;
in {
    programs.ssh = {
        enable = true;
        controlMaster = "auto";
        controlPath = "~/.ssh/master-%C";
        controlPersist = "10m";
        matchBlocks = let
            lenient = {
                extraOptions = {
                    "HostKeyAlgorithms" = "+ssh-dss";
                    "KexAlgorithms" = "+diffie-hellman-group1-sha1";
                    "Ciphers" = "+aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc";
                };
            };
        in {
            "arcvault-1" = {
                hostname = "arcvault-1.local";
                user = "pi";
            };

            "10.8.3.*" = lenient;
            "2a10:4a80:7:3:*" = lenient;

            "switch-r1core1.stir1.arctarus.net" = recursiveUpdate lenient {
                user = "joseph";
                extraOptions = {
                    # old machine, sending public keys sometimes makes it crash
                    "PubkeyAuthentication" = "no";
                };
            };
        };
    };
}