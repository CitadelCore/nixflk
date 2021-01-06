final: prev: {
    juju = prev.callPackage ./applications/networking/juju { };
    enigma = prev.callPackage ./applications/games/enigma { };
    colmena = prev.callPackage ./tools/package-management/colmena { };
}
