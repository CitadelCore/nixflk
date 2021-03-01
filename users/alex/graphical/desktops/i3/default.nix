{ pkgs, ... }:
{
    imports = [
        ./dunst.nix
        ./i3.nix
        ./i3lock.nix
        ./polybar.nix
        ./rofi.nix
    ];

    gtk = rec {
        enable = true;

        font = {
            name = "Noto Sans";
            package = pkgs.noto-fonts;
        };

        gtk3.extraCss = ''
            VteTerminal, vte-terminal {
                padding: 15px;
            }
        '';
    };

    programs.firefox = {
        enable = true;
    };

    programs.chromium = {
        enable = true;
        package = pkgs.google-chrome;
    };
}