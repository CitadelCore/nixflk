final: prev: with prev; {
    omnisharp-roslyn = prev.omnisharp-roslyn.overrideAttrs(o: {
        src = fetchurl {
            url = "https://arc-extern.s3.eu-west-2.amazonaws.com/omnisharp-mono.tar.gz";
            sha256 = "sha256-OC4z3Fv+YSN+rdO4gZAHyPbgGOr8TD/24XNIfJvIS2w=";
        };
    });
}