{ config, lib, pkgs, ... }:
{
    services.polybar = {
        enable = true;
        config = {
            "settings" = {
                screenchange-reload = true;
            };

            "global/wm" = {
                margin-top = 5;
                margin-bottom = 5;
            };

            "colors" = {
                custom_foreground = "\${xrdb:custom_foreground}";
                custom_foreground_alt = "\${xrdb:custom_foreground_alt}";
                custom_background_dark = "\${xrdb:custom_background_dark}";
                custom_background_light = "\${xrdb:custom_background_light}";
                custom_primary = "\${xrdb:custom_primary}";
                custom_warn = "\${xrdb:custom_warn}";

                foreground = "\${colors.custom_foreground}";
                foreground-alt = "\${colors.custom_foreground_alt}";
                background = "\${colors.custom_background_dark}";
                background-alt = "\${colors.custom_background_light}";
                primary = "\${colors.custom_primary}";
                ok = "\${colors.custom_foreground}";
                alert = "\${colors.custom_warn}";
            };

            "bar/primary" = {
                width = "100%";
                height = 27;
                fixed-center = false;

                background = "\${colors.background}";
                foreground = "\${colors.foreground}";

                line-size = 3;
                line-color = "#f00";

                padding-left = 0;
                padding-right = 2;

                module-margin-left = 1;
                module-margin-right = 2;

                font-0 = "FuraCode Nerd Font:pixelSize=10;1";

                modules-left = "i3";
                modules-right = "pulseaudio memory cpu network-wlan network-eth battery temperature date powermenu";

                tray-position = "right";
                tray-padding = 2;

                cursor-click = "pointer";
                cursor-scroll = "ns-resize";
            };

            "module/i3" = {
                type = "internal/i3";
                format = "<label-state> <label-mode>";
                index-sort = true;
                wrapping-scroll = false;
                strip-wsnumbers = false;

                # Only show workspaces on the same output as the bar
                pin-workspaces = true;

                label-mode-padding = 2;
                label-mode-foreground = "#000";
                label-mode-background = "\${colors.foreground}";

                # focused = Active workspace on focused monitor
                label-focused = "%index%";
                label-focused-background = "#444";
                label-focused-underline = "\${colors.foreground-alt}";
                label-focused-padding = 2;

                # unfocused = Inactive workspace on any monitor
                label-unfocused = "%index%";
                label-unfocused-padding = 2;

                # visible = Active workspace on unfocused monitor
                label-visible = "%index%";
                label-visible-background = "\${self.label-focused-background}";
                label-visible-underline = "\${self.label-focused-underline}";
                label-visible-padding = "\${self.label-focused-padding}";

                # urgent = Workspace with urgency hint set
                label-urgent = "%index%";
                label-urgent-background = "\${colors.alert}";
                label-urgent-padding = 2;
            };

            "module/pulseaudio" = {
                type = "internal/pulseaudio";

                format-volume = "<label-volume> <bar-volume>";
                format-volume-prefix = "墳 ";
                format-volume-prefix-foreground = "\${colors.foreground}";
                label-volume = "%percentage%%";
                label-volume-foreground = "\${colors.foreground-alt}";

                label-muted = "婢 muted";
                label-muted-foreground = "#666";

                bar-volume-width = 10;
                bar-volume-foreground-0 = "\${colors.foreground}";
                bar-volume-gradient = false;
                bar-volume-indicator = "|";
                bar-volume-indicator-font = 0;
                bar-volume-fill = "─";
                bar-volume-fill-font = 0;
                bar-volume-empty = "─";
                bar-volume-empty-font = 0;
                bar-volume-empty-foreground = "\${colors.foreground-alt}";
            };

            "module/memory" = {
                type = "internal/memory";
                interval = 2;
                format-prefix = " ";
                format-prefix-foreground = "\${colors.foreground-alt}";
                label = "%percentage_used%%";
            };

            "module/cpu" = {
                type = "internal/cpu";
                interval = 2;
                format = "<label> <ramp-coreload>";
                format-prefix = "ﲾ ";
                format-prefix-foreground = "\${colors.foreground-alt}";
                label = "%percentage:2%%";

                ramp-coreload-spacing = 1;
                ramp-coreload-0 = "▁";
                ramp-coreload-1 = "▂";
                ramp-coreload-2 = "▃";
                ramp-coreload-3 = "▄";
                ramp-coreload-4 = "▅";
                ramp-coreload-5 = "▆";
                ramp-coreload-6 = "▇";
                ramp-coreload-7 = "█";
            };

            "module/network-wlan" = {
                type = "internal/network";
                interface = "wlp0s20f3";
                interval = 3;

                format-connected = "<ramp-signal> <label-connected>";
                format-connected-underline = "\${colors.foreground}";
                label-connected = "%essid%";

                format-disconnected = "";

                ramp-signal-0 = "";
                ramp-signal-1 = "";
                ramp-signal-2 = "";
                ramp-signal-3 = "";
                ramp-signal-4 = "";
                ramp-signal-foreground = "\${colors.foreground-alt}";
            };

            "module/network-eth" = {
                type = "internal/network";
                interface = "enp0s31f6";
                interval = 3;

                format-connected-underline = "#55aa55";
                format-connected-prefix = " ";
                format-connected-prefix-foreground = "\${colors.foreground-alt}";
                label-connected = "%local_ip%";

                format-disconnected = "";
            };

            "module/battery" = {
                type = "internal/battery";
                battery = "BAT0";
                adapter = "AC";
                full-at = 96;

                format-charging = "<ramp-capacity> <label-charging>";
                format-charging-underline = "\${colors.foreground}";

                format-discharging = "<ramp-capacity> <label-discharging>";
                format-discharging-underline = "\${self.format-charging-underline}";

                format-full-prefix = " ";
                format-full-prefix-foreground = "\${colors.foreground-alt}";
                format-full-underline = "\${self.format-charging-underline}";

                ramp-capacity-0 = " ";
                ramp-capacity-1 = " ";
                ramp-capacity-2 = " ";
                ramp-capacity-3 = " ";
                ramp-capacity-4 = " ";
                ramp-capacity-5 = " ";
                ramp-capacity-6 = " ";
                ramp-capacity-7 = " ";
                ramp-capacity-8 = " ";
                ramp-capacity-foreground = "\${colors.foreground-alt}";
            };

            "module/temperature" = {
                type = "internal/temperature";
                thermal-zone = 0;
                warn-temperature = 60;

                format = "<ramp> <label>";
                format-underline = "\${colors.ok}";
                format-warn = "<ramp> <label-warn>";
                format-warn-underline = "\${self.format-underline}";

                label = "%temperature-c%";
                label-warn = "%temperature-c%";
                label-warn-foreground = "\${colors.alert}";

                ramp-0 = "";
                ramp-1 = "";
                ramp-2 = "";
                ramp-foreground = "\${colors.foreground-alt}";
            };

            "module/date" = {
                type = "internal/date";
                interval = 5;

                date = "";
                date-alt = " %Y-%m-%d";

                time = "%H:%M";
                time-alt = "%H:%M:%S";

                format-prefix = "";
                format-prefix-foreground = "\${colors.foreground-alt}";

                label = "%date% %time%";
            };

            "module/powermenu" = {
                type = "custom/menu";
                expand-right = true;
                format-spacing = 1;

                label-open = "";
                label-open-foreground = "\${colors.foreground-alt}";
                label-close = "ﰸ cancel";
                label-close-foreground = "\${colors.foreground-alt}";
                label-separator = "|";
                label-separator-foreground = "\${colors.foreground}";

                menu-0-0 = "ﰇ reboot";
                menu-0-0-exec = "menu-open-1";
                menu-0-1 = "襤 power off";
                menu-0-1-exec = "menu-open-2";

                menu-1-0 = "cancel";
                menu-1-0-exec = "menu-open-0";
                menu-1-1 = "reboot";
                menu-1-1-exec = "systemctl reboot";

                menu-2-0 = "power off";
                menu-2-0-exec = "systemctl poweroff";
                menu-2-1 = "cancel";
                menu-2-1-exec = "menu-open-0";
            };
        };

        script = "polybar primary &";
    };
}