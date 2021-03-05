{ pkgs, ... }:
{
    imports = [
        ../../capabilities/fingerprint
    ];

    # use the newer DCAP SGX driver because we have FLC support
    security.sgx.packages.driver = pkgs.linuxPackages.intel-sgx-dcap;
}