{ lib, ... }:
{
    boot = {
        loader = {
            grub.enable = false;

            systemd-boot = let
                basePath = "/persist/nixos/secrets/secureboot";
            in {
                enable = true;
                signed = true;
                signing-key = "${basePath}/db.key";
                signing-certificate = "${basePath}/db.crt";
            };
        };

        initrd.preLVMCommands = lib.mkBefore ''
            echo '!!! OPERATOR WARNING !!!'
            echo 'This system is property of Alex Zero and is equipped with an anti-tamper and tracking system.'
            echo 'If you have found this device, please immediately email me at alex@arctarus.co.uk or phone me at +44 7472026349.'
            echo '!!! OPERATOR WARNING !!!'
        '';
    };
}