final: prev: {
    juju = prev.callPackage ./applications/networking/juju { };
    enigma = prev.callPackage ./applications/games/enigma { };
    libcamera = prev.callPackage ./development/libraries/libcamera { };
    colmena = prev.callPackage ./tools/package-management/colmena { };
}
