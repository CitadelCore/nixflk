{ lib, pkgs, ... }:

let
    inherit (lib.hm.gvariant) mkTuple mkUint32;
in
{
    home.packages = with pkgs; [ dconf2nix ];

    dconf.settings = {
        "org/gnome/desktop/input-sources" = {
            "current" = mkUint32 0;
            "sources" = [ (mkTuple [ "xkb" "us" ]) ];
            "xkb-options" = [ "terminate:ctrl_alt_bksp" "lv3_ralt_switch" ];
        };
    };
}