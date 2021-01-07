{ pkgs, ... }:
{
    imports = [
        ./certs
        ./pam
        ./smartcard
    ];

    programs.ssh.startAgent = true;

    security = {
        protectKernelImage = true;
        hideProcessInformation = true;
    };
}