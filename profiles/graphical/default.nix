{ pkgs, ... }:
{
    hardware = {
        opengl = {
            enable = true;
            driSupport = true;
        };

        pulseaudio = {
            enable = true;
            package = pkgs.pulseaudioFull;
        };

        bluetooth.enable = true;
    };

    services = {
        xserver = {
            enable = true;
            
            libinput.enable = true;
            displayManager.lightdm.enable = true;
            desktopManager.plasma5.enable = true;
        };

        redshift.enable = true;
    };
}
