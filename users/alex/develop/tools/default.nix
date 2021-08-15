{ pkgs, ... }:
{
    imports = [
        ./vscode
    ];

    home.packages = with pkgs; [
        # nix stuff
        nixfmt
        nix-index
        nix-prefetch
        nix-prefetch-docker
        nix-prefetch-scripts

        # utility
        asciinema gnumake file less wget shellcheck
        diffstat diffutils findutils patch gawk graphviz
        ripgrep-all

        # hardware
        acpica-tools iasl efivar
        libmbim libqmi

        # security
        openssl git-crypt git-secrets gnupg mkpasswd
    ];
}