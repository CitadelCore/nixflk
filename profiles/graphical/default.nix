{ pkgs, ... }:
{
    sound.enable = true;
    console.useXkbConfig = true;

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

    services = {
        xserver = {
            enable = true;
            libinput.enable = true;
        };

        gnome3.chrome-gnome-shell.enable = true;
    };

    security.chromiumSuidSandbox.enable = true;

    environment.systemPackages = with pkgs; [
        playerctl pavucontrol alsaTools
        modem-manager-gui
    ];

    programs.dconf.enable = true;
}
