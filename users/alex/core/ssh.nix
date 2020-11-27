{ config, lib, pkgs, ... }:
{
    programs.ssh = {
        enable = true;
        matchBlocks = {
            "arcvault-1" = {
                hostname = "arcvault-1.local";
                user = "pi";
            };

            "deployer.int.arctarus.co.uk" = {
                hostname = "deployer.int.arctarus.co.uk";
                user = "jmarsden";
            };

            "10.8.3.*" = {
                extraOptions = {
                    "HostKeyAlgorithms" = "+ssh-dss";
                    "KexAlgorithms" = "+diffie-hellman-group1-sha1";
                    "Ciphers" = "+aes128-cbc,3des-cbc,aes192-cbc,aes256-cbc";
                };
            };

            "10.8.3.11" = lib.hm.dag.entryAfter ["10.8.3.*"] {
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