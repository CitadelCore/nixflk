{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.security.sgx;
in
{
    options.security.sgx = {
        enable = mkEnableOption "Intel SGX";

        packages = {
            psw = mkOption {
                default = pkgs.intel-sgx-psw;
                defaultText = "pkgs.intel-sgx-psw";
                description = "The SGX PSW (platform software) package to use.";
            };

            sdk = mkOption {
                default = pkgs.intel-sgx-sdk;
                defaultText = "pkgs.intel-sgx-sdk";
                description = "The SGX SDK (software development kit) package to use.";
            };

            driver = mkOption {
                type = types.package;
                default = pkgs.linuxPackages.intel-sgx-sgx1;
                defaultText = "pkgs.linuxPackages.intel-sgx-sgx1";
                example = literalExample "pkgs.linuxPackages.intel-sgx-dcap";
                description = "The SGX driver package to use.";
            };
        };
    };

    config = mkIf cfg.enable {
        boot.extraModulePackages = [ cfg.packages.driver ];
        services.udev.packages = [ cfg.packages.psw ];
    };
}
