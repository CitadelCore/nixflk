{
    programs.termite = {
        enable = true;

        allowBold = true;
        audibleBell = false;

        cursorColor = "#c5c8c6";
        foregroundColor = "#c5c8c6";
        foregroundBoldColor = "#c5c8c6";
        backgroundColor = "#1d1f21";
        highlightColor = "#2f2f2f";

        colorsExtra = ''
            # black
            color0 = #282a2e
            color8 = #373b41

            # red
            color1 = #e91414
            color9 = #ea3737

            # green
            #color2 = #8c9440
            #color10 = #b5bd68

            # yellow
            color3 = #de935f
            color11 = #f0c674

            # blue
            color4 = #04f1fc
            color12 = #06acfe

            # magenta
            color5 = #ff1d81
            color13 = #cc1e6f

            # cyan
            #color6 = #5e8d87
            #color14 = #8abeb7

            # white
            color7 = #707880
            color15 = #c5c8c6
        '';
    };
}