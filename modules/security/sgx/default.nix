{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.security.sgx;
in
{
    options.security.sgx = {
        enable = mkEnableOption "Intel SGX";

        driver = mkOption {
            type = types.package;
            default = pkgs.linuxPackages.intel-sgx-driver;
            defaultText = "pkgs.linuxPackages.intel-sgx-driver";
            example = literalExample "pkgs.linuxPackages.intel-sgx-dcap";
            description = "The SGX driver package to use.";
        };
    };

    config = mkIf cfg.enable {
        boot.extraModulePackages = [ cfg.driver ];
    };
}
