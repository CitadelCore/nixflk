final: prev: with prev; {
    omnisharp-roslyn = prev.omnisharp-roslyn.overrideAttrs(o: {
        src = fetchFromGitHub {
            owner = "CitadelCore";
            repo = "omnisharp-roslyn";
            rev = "master";
            sha256 = "sha256-aZwrsIRidKK815x6/HpurQ5FyGPn7kYKQRLrowXMGlU=";
        };
    });
}