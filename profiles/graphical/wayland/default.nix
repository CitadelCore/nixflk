{ pkgs, ... }:
{
    services.pipewire.enable = true;
    services.xserver.displayManager.gdm.wayland = true;

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-wlr
            xdg-desktop-portal-gtk
        ];

        gtkUsePortal = true;
    };
}