{ config, lib, pkgs, my, ... }: let
    inherit (lib) optionalAttrs;
in {
    programs.gpg = {
        enable = true;
        settings = {
            "default-key" = my.pgp.fingerprint;
            "no-emit-version" = true;
            "no-comments" = true;
            "keyid-format" = "0xlong";
            "with-fingerprint" = true;
            "list-options" = "show-uid-validity";
            "verify-options" = "show-uid-validity";
            "use-agent" = true;

            # keyserver
            "keyserver" = "hkp://keys.gnupg.net:80";
            "keyserver-options" = "no-honor-keyserver-url include-revoked";

            # ciphers
            "personal-cipher-preferences" = "AES256 AES192 AES CAST5";
            "personal-digest-preferences" = "SHA512 SHA384 SHA256 SHA224";
            "cert-digest-algo" = "SHA512";
            "default-preference-list" = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
        };

        scdaemonSettings = {
            card-timeout = "1";
            disable-ccid = true;
            reader-port = "Yubico YubiKey";
        };
    };

    services.gpg-agent = {
        enable = !my.wsl;
        enableSshSupport = true;
    };

    home.sessionVariables = {
        "SOPS_PGP_FP" = my.pgp.fingerprint;
    } // (optionalAttrs (!my.wsl) {
        "SSH_AUTH_SOCK" = "/run/user/$UID/gnupg/S.gpg-agent.ssh";
    });
}
