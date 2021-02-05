{ pkgs, ... }:
{
    imports = [
        ./autorandr.nix
        ./barrier.nix
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

        theme = {
            name = "Adwaita";
            package = pkgs.gnome3.gnome_themes_standard;
        };

        iconTheme = theme;

        gtk3.extraCss = ''
            VteTerminal, vte-terminal {
                padding: 15px;
            }
        '';
    };
}