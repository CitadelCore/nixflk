{ lib, pkgs, ... }:

let
    inherit (lib.hm.gvariant) mkTuple mkUint32;
in
{
    dconf.settings = {
        "org/gnome/desktop/input-sources" = {
            "current" = mkUint32 0;
            "sources" = [ (mkTuple [ "xkb" "gb" ]) ];
            "xkb-options" = [ "terminate:ctrl_alt_bksp" "lv3_ralt_switch" ];
        };
    };
}
