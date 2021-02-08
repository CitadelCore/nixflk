final: prev: let
    buildIntelSGX = type: prev.callPackage (import ./misc/sgx { inherit type; }) { };
in {
    # applications
    juju = prev.callPackage ./applications/networking/juju { };
    enigma = prev.callPackage ./applications/games/enigma { };

    # development
    libcamera = prev.callPackage ./development/libraries/libcamera { };

    # misc
    intel-sgx-sdk = buildIntelSGX "sdk";
    intel-sgx-psw = buildIntelSGX "psw";

    # os-specific
    linuxPackages = import ./os-specific/linux { inherit final prev; };

    # tools
    colmena = prev.callPackage ./tools/package-management/colmena { };
}
