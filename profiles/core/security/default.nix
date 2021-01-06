{ pkgs, ... }:
{
    imports = [
        ./pam.nix
        ./smartcard.nix
    ];

    programs.ssh.startAgent = true;

    security = {
        # install certification authorities
        pki.certificateFiles = [ ./ca/arctarus.pem ];

        protectKernelImage = true;
        hideProcessInformation = true;
    };
}