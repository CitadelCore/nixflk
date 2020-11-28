{ config, lib, pkgs, ... }:
{
    imports = [
        ./comms
        ./creative
        ./games
        ./media

        ./autorandr.nix
        ./dunst.nix
        ./i3.nix
        ./i3lock.nix
        ./polybar.nix
        ./rofi.nix
        ./termite.nix
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

    services.redshift = {
        enable = true;
        provider = "geoclue2";
    };

    xresources.extraConfig = (
        lib.fileContents ./xresources.conf
    );
}