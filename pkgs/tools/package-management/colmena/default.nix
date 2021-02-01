{ fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage {
    name = "colmena";
    version = "0.1.0";

    src = fetchFromGitHub {
        owner = "zhaofengli";
        repo = "colmena";
        rev = "f53ebef41c26b3b4cb024685e952a4450b631bd6";
        sha256 = "sha256-I26WdIqM3lNSCrJnO+7nVLOFGn7wzVmdaRfpqD4lW50=";
    };

    cargoSha256 = "sha256-F3NRnNvHV3jQ6cknNgqmsu7Z4kvBgOSkre/Gry2CHMo=";
}