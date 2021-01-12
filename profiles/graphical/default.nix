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
    };

    environment.systemPackages = with pkgs; [
        playerctl pavucontrol alsaTools
    ];

    programs.dconf.enable = true;
}
