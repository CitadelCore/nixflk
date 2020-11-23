{ pkgs, ... }:
{
    sound.enable = true;

    hardware = {
        opengl = {
            enable = true;
            driSupport = true;
        };

        pulseaudio = {
            enable = true;
            package = pkgs.pulseaudioFull;
        };
    };

    services.xserver = {
        enable = true;
        
        libinput.enable = true;
        displayManager.lightdm.enable = true;
        windowManager.i3.enable = true;
    };

    environment.systemPackages = with pkgs; [
        playerctl
        pavucontrol
        libnotify
    ];

    programs.dconf.enable = true;
}
