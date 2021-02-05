{ lib, pkgs, ... }:

let
    inherit (lib.hm.gvariant) mkTuple;
in
{
    home.packages = with pkgs; [ dconf2nix ];

    dconf.settings = {
        "org/gnome/desktop/input-sources" = {
            "current" = "uint32 0";
            "sources" = [ (mkTuple [ "xkb" "us" ]) ];
            "xkb-options" = [ "terminate:ctrl_alt_bksp" "lv3_ralt_switch" ];
        };

        "org/gnome/desktop/interface" = {
            "gtk-im-module" = "ibus";
            "gtk-theme" = "Adwaita-dark";
        };

        "org/gnome/settings-daemon/plugins/power" = {
            # autobrightness is very stuttery, so turn it off
            "ambient-enabled" = false;

            # disable automatic sleep on AC power
            "sleep-inactive-ac-type" = "nothing";
        };

        "org/gnome/shell/weather" = {
            "automatic-location" = true;
        };

        "org/gnome/system/location" = {
            "enabled" = true;
        };
    };
}