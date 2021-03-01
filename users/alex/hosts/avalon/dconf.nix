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
    };
}