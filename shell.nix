{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
    name = "nixflk";
    nativeBuildInputs = with pkgs; [
        git
        git-crypt
        nixFlakes
    ];

    shellHook = ''
        PATH=${
        pkgs.writeShellScriptBin "nix" ''
            ${pkgs.nixFlakes}/bin/nix --option experimental-features "nix-command flakes ca-references" "$@"
        ''
        }/bin:$PATH
    '';
}
