{ pkgs, ... }:
{
    imports = [
        ./certs
        ./hardening
        ./pam
        ./smartcard
    ];

    programs.ssh.startAgent = true;

    security = {
        # replace sudo with doas
        sudo.enable = false;

        doas = {
            enable = true;
            extraRules = [
                { groups = [ "wheel" ]; noPass = false; persist = true; }
            ];
        };
    };
}
