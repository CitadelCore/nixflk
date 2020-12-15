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
            support32Bit = true; # Steam, etc
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
        vlc
        playerctl
        pavucontrol
        libnotify
        networkmanagerapplet

        libreoffice-fresh

        gnome3.eog
        gnome3.nautilus
        gnome3.file-roller
    ];

    programs.dconf.enable = true;
}
