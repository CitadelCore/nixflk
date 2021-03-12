{
    boot.loader = {
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
}