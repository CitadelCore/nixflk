{ config, lib, pkgs, ... }:
let
    mod = "Mod4";
in
{
    xsession.windowManager.i3 = {
        enable = true;
        config = {
            modifier = mod;
            fonts = ["monospace 8"];

            keybindings = lib.mkOptionDefault {
                "${mod}+Return" = "exec termite";
                "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -modi drun -opacity 70";
                "${mod}+L" = "exec <lock-screen.sh>";

                "Print" = "exec ${pkgs.flameshot}/bin/flameshot full -c -p ~/Pictures/screenshots";
                "Shift+Print" = "exec ${pkgs.flameshot}/bin/flameshot gui -p ~/Pictures/screenshots";

                # on G915, play does the same as pause
                "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
                "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
                "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
                "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

                # other function keys
                "XF86Calculator" = "exec gnome-calculator";
            };

            startup = [
                { command = "${pkgs.flameshot}/bin/flameshot"; notification = false; }
                #{ command = "${pkgs.polybar}/bin/polybar -r primary"; notification = false; }
            ];

            floating.criteria = [
                { title = "Steam - Update News"; }
                { class = "Pavucontrol"; }
                { class = "chaos"; }
            ];
        };
    };
}