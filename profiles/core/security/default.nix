{ pkgs, ... }:
{
    imports = [
        ./pam.nix
        ./smartcard.nix
    ];

    environment.systemPackages = with pkgs; [
        _1password _1password-gui
    ];

    programs.ssh.startAgent = true;

    security = {
        # install certification authorities
        pki.certificateFiles = [ ./ca/arctarus.pem ];

        hideProcessInformation = true;
        protectKernelImage = true;
    };
}