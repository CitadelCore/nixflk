{ pkgs, ... }:
{
    services.dunst = {
        enable = true;

        iconTheme = {
            name = "Adwaita";
            package = pkgs.gnome3.adwaita-icon-theme;
        };

        settings = {
            "global" = {
                # Display
                monitor = 0;
                follow = "mouse";
                geometry = "300x5-30+20";
                indicate_hidden = true;
                shrink = false;
                transparency = 0;
                notification_height = 0;
                separator_height = 2;
                padding = 8;
                horizontal_padding = 8;
                frame_width = 2;
                frame_color = "#ff28aa";
                separator_color = "frame";
                sort = true;
                idle_threshold = 120;
                font = "FuraCode Nerd Font 8";
                line_height = 0;
                markup = "full";
                format = "<b>%s</b>\n%b";
                alignment = "left";
                show_age_threshold = 60;
                word_wrap = true;
                ellipsize = "middle";
                ignore_newline = false;
                stack_duplicates = true;
                hide_duplicate_count = false;
                show_indicators = true;

                # Icons
                icon_position = "left";
                max_icon_size = 32;

                # History
                sticky_history = true;
                history_length = 20;

                # Misc/Advanced
                dmenu = "${pkgs.rofi}/bin/rofi -show drun -modi drun -opacity 70";
                browser = "${pkgs.firefox}/bin/firefox";
                always_run_script = true;
            };

            "urgency_low" = {
                background = "#111";
                foreground = "#04f1fc";
                timeout = 10;
            };

            "urgency_normal" = {
                background = "#111";
                foreground = "#04f1fc";
                timeout = 10;
            };

            "urgency_critical" = {
                background = "#111";
                foreground = "#ff0000";
                frame_color = "#ff0000";
                timeout = 600;
            };
        };
    };
}