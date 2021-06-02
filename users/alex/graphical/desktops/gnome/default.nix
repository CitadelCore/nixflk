{ pkgs, ... }:
{
    programs.firefox = {
        enable = true;
        package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
            forceWayland = true;
            cfg.enableGnomeExtensions = true;
            # pkcs11Modules = [ pkgs.yubico-piv-tool ]; # TODO
        };

        profiles.default.settings = {
            # hardware video acceleration
            "media.ffmpeg.vaapi.enabled" = true;
            "media.ffvpx.enabled" = false;
            "media.rdd-vpx.enabled" = false;
        };
    };

    # disable, this makes us build chromium from source
    # which takes fucking FOREVER
    # programs.chromium = {
    #     enable = true;
    #     package = pkgs.chromium.override {
    #         enableWideVine = true;
    #     };
    # };

    systemd.user.sessionVariables = {
        MOZ_USE_XINPUT2 = "1";
    };

    home.packages = with pkgs; [
        gnome3.dconf-editor
        gnome3.gnome-shell-extensions
        gnomeExtensions.appindicator
    ];

    dconf.settings = {
        "org/gnome/shell" = {
            # enable our extensions here
            enabled-extensions = [
                "appindicatorsupport@rgcjonas.gmail.com"
            ];
        };
    };
}