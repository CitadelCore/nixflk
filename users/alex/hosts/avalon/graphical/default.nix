{ pkgs, ... }:
{
    imports = [ ./dconf.nix ];

    programs.firefox = {
        enable = true;
        package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
            forceWayland = true;
        };

        profiles.default.settings = {
            # hardware video acceleration
            "media.ffvpx.enabled" = false;
            "media.ffmpeg.vaapi.enabled" = true;
        };
    };

    home.sessionVariables = {
        "MOZ_ENABLE_WAYLAND" = 1;
        "MOZ_USE_XINPUT2" = 1;
        "XDG_SESSION_TYPE" = "wayland";
    };
}