{ lib, ... }:

let
    inherit (lib.hm.gvariant) mkTuple;
in
{
    dconf.settings = {
        "org/gnome/desktop/input-sources" = {
            "current" = "uint32 0";
            "sources" = [ (mkTuple [ "xkb" "gb" ]) ];
            "xkb-options" = [ "terminate:ctrl_alt_bksp" "lv3_ralt_switch" ];
        };

        "org/gnome/settings-daemon/plugins/power" = {
            # disable automatic sleep on AC power
            "sleep-inactive-ac-type" = "nothing";
        };
    };
}