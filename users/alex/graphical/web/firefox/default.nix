{ lib, pkgs, ... }: let
    inherit (lib) mkDefault;
in {
    programs.firefox = {
        enable = true;
        package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
            # pkcs11Modules = [ pkgs.yubico-piv-tool ]; # TODO

            # TODO: need module enablement conditionals?? This is currently only for Gnome
            # TODO: DO NOT COMMIT! BROKEN!
            # forceWayland = config.services.xserver.desktopManager.gnome.enable;
            # cfg.enableGnomeExtensions = mkDefault config.services.xserver.desktopManager.gnome.enable;
        };

        profiles.default.settings = {
            # hardware video acceleration
            "media.ffmpeg.vaapi.enabled" = true;
            "media.ffvpx.enabled" = false;
            "media.rdd-vpx.enabled" = false;
        };
    };

    systemd.user.sessionVariables = {
        MOZ_USE_XINPUT2 = "1";
    };
}