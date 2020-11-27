{ config, lib, pkgs, ... }:
{
    programs.gpg = {
        enable = true;
        settings = {
            "default-key" = "0xA51550EDB450302C";
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
    };

    services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
    };

    programs.bash.initExtra = ''
        export GPG_TTY="$(tty)"
        gpg-connect-agent /bye
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
    '';
}