{ lib, pkgs, ... }: let
    inherit (lib) concatStringsSep;
in {
    home = {
        packages = with pkgs; [
            (lib.hiPrio clang) lldb gcc
            pkg-config protobuf
            intel-sgx-sdk
        ];

        sessionVariables = {
            "SGX_SDK" = "${pkgs.intel-sgx-sdk}/usr/share/sgxsdk";
            "PKG_CONFIG_PATH" = concatStringsSep ":" [
                "${pkgs.openssl.dev}/lib/pkgconfig"
                "${pkgs.intel-sgx-sdk}/lib64/pkgconfig"
            ];
        };
    };
}