{ pkgs, ... }:
{
    boot = {
        plymouth = {
            enable = false;
            logo = ./logo.png;
        };

        # enable the SGX driver for all machines
        extraModulePackages = with pkgs.linuxPackages; [
            intel-sgx-dcap
        ];
    };
}
