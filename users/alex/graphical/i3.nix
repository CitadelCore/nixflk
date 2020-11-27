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
            bars = [];

            menu = "${pkgs.rofi}/bin/rofi -show drun -modi drun -opacity 70";

            keybindings = lib.mkOptionDefault {
                "${mod}+Return" = "exec termite";
                "${mod}+L" = "exec --no-startup-id ${pkgs.systemd}/bin/loginctl lock-session";
                "${mod}+Shift+e" = "exec --no-startup-id rofi -show power-menu -modi power-menu:rofi-power-menu -width 20 -lines 6";

                # screenshots
                "Print" = "exec ${pkgs.flameshot}/bin/flameshot full -c -p ~/Pictures/screenshots";
                "Shift+Print" = "exec ${pkgs.flameshot}/bin/flameshot gui -p ~/Pictures/screenshots";

                # audio controls
                "XF86AudioMute" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
                "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
                "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";

                # on G915, play does the same as pause
                "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
                "XF86AudioPause" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
                "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
                "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

                # other function keys
                "XF86Calculator" = "exec gnome-calculator";
            };

            modes.resize = {
                "Left" = "resize shrink width 10 px or 10 ppt";
                "Down" = "resize grow height 10 px or 10 ppt";
                "Up" = "resize shrink height 10 px or 10 ppt";
                "Right" = "resize grow width 10 px or 10 ppt";

                # back to normal: Enter or Escape or $mod+r
                "Return" = "mode default";
                "Escape" = "mode default";
                "${mod}+r" = "mode default";
            };

            startup = [
                { command = "${pkgs.flameshot}/bin/flameshot"; notification = false; }
                { command = "${pkgs.xorg.xrdb}/bin/xrdb -load ~/.Xresources"; notification = false; always = true; }
            ];

            floating.criteria = [
                { title = "Steam - Update News"; }
                { class = "Pavucontrol"; }
                { class = "chaos"; }
            ];
        };
    };
}