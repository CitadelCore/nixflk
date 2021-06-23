{ pkgs, ... }:
{
    home.packages = with pkgs; [
        gnome3.dconf-editor
        gnome3.gnome-shell-extensions
        gnomeExtensions.appindicator
    ];

    dconf.settings = {
        "org/gnome/shell" = {
            # enable our extensions here
            enabled-extensions = [
                "appindicatorsupport@rgcjonas.gmail.com"
            ];
        };
    };
}