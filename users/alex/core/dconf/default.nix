{ lib, pkgs, ... }:

let
    inherit (lib.hm.gvariant) mkTuple;
in
{
    home.packages = with pkgs; [ dconf2nix ];

    dconf.settings = {
        "org/gnome/desktop/input-sources" = {
            "current" = "uint32 0";
            "sources" = [ (mkTuple [ "xkb" "gb" ]) ];
            "xkb-options" = [ "terminate:ctrl_alt_bksp" "lv3_ralt_switch" ];
        };

        "org/gnome/desktop/interface" = {
            "gtk-im-module" = "ibus";
            "gtk-theme" = "Adwaita-dark";
        };

        "org/gnome/desktop/screensaver" = {
            "idle-activation-enabled" = false;
            "lock-delay" = "uint32 0";
        };

        "org/gnome/desktop/session" = {
            # do not automatically lock
            "idle-delay" = "uint32 0";
        };

        "org/gnome/settings-daemon/plugins/power" = {
            # disable automatic sleep on AC power
            "idle-dim" = false;
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
