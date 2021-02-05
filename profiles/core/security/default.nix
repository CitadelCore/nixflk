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

        # currently required for polkit to work properly...
        # hideProcessInformation = true;
    };
}