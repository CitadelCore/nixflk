{ pkgs, ... }:
{
    imports = [
        ../../capabilities/fingerprint
        ../../capabilities/graphics/nvidia
        ../../capabilities/graphics/nvidia/prime
    ];

    # use the newer DCAP SGX driver because we have FLC support
    security.sgx.packages.driver = pkgs.linuxPackages.intel-sgx-dcap;

    # enable nvidia support for Docker as we have a nvidia card
    virtualisation.docker.enableNvidia = true;
}