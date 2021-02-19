{ config, lib, pkgs, ... }:
{
    programs.ssh = {
        enable = true;
        controlMaster = "auto";
        controlPath = "~/.ssh/master-%C";
        controlPersist = "10m";
        matchBlocks = {
            "arcvault-1" = {
                hostname = "arcvault-1.local";
                user = "pi";
            };

            "deployer.stir1.arctarus.net" = {
                hostname = "deployer.stir1.arctarus.net";
                user = "jmarsden";
            };

            "10.8.3.*" = {
                extraOptions = {
                    "HostKeyAlgorithms" = "+ssh-dss";
                    "KexAlgorithms" = "+diffie-hellman-group1-sha1";
                    "Ciphers" = "+aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc";
                };
            };

            "10.8.3.58" = lib.hm.dag.entryAfter ["10.8.3.*"] {
                user = "joseph";
                extraOptions = {
                    "PubkeyAuthentication" = "no";
                };
            };

            "*.arctarus.co.uk".user = "jmarsden";
            "*.as210072.net".user = "jmarsden";
            "*.as50329.net".user = "jmarsden";
            "2a0d:1a40:7551:*".user = "jmarsden";
            "2a0d:1a40:561:*".user = "jmarsden";
            "2a10:4a80:*".user = "jmarsden";
        };
    };
}