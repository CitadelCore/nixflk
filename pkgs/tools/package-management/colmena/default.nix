{ fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage {
    name = "colmena";
    version = "0.1.0";

    src = fetchFromGitHub {
        owner = "zhaofengli";
        repo = "colmena";
        rev = "1125eb6d1bf4d07213087c0ade68c15f471d3654";
        sha256 = "sha256-Lcqv8zQVyJqrytLg8X271swUKJfACnIpxh05qHmxSLE=";
    };

    cargoSha256 = "sha256-F3NRnNvHV3jQ6cknNgqmsu7Z4kvBgOSkre/Gry2CHMo=";
}