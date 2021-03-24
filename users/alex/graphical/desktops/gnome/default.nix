{ pkgs, ... }:
{
    programs.firefox = {
        enable = true;
        package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
            forceWayland = true;
        };

        enableGnomeExtensions = true;

        profiles.default.settings = {
            # hardware video acceleration
            "media.ffmpeg.vaapi.enabled" = true;
            "media.ffvpx.enabled" = false;
            "media.rdd-vpx.enabled" = false;
        };
    };

    programs.chromium = {
        enable = true;
        package = pkgs.chromium.override {
            enableWideVine = true;
        };
    };

    systemd.user.sessionVariables = {
        # Hack? Should be set in hardware profile
        LIBVA_DRIVER_NAME = "iHD";
        MOZ_ENABLE_WAYLAND = "1";
        MOZ_USE_XINPUT2 = "1";
        QT_QPA_PLATFORM = "wayland";
        XDG_SESSION_TYPE = "wayland";
    };

    home.packages = with pkgs; [
        gnome3.dconf-editor
        gnome3.gnome-shell-extensions
        gnomeExtensions.topicons-plus
    ];

    dconf.settings = {
        "org/gnome/shell" = {
            # enable our extensions here
            enabled-extensions = [
                "TopIcons@phocean.net"
            ];
        };

        "org/gnome/shell/extensions/topicons" = {
            tray-pos = "right";
        };
    };
}