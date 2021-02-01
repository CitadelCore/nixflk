{ pkgs, ... }:
{
    boot = {
        # we're hidpi so use lower res for boot
        loader.systemd-boot.consoleMode = "1";

        # use latest kernel version
        kernelPackages = pkgs.linuxPackages_5_10;
        kernelPatches = [
            # fix for the keyboard function keys
            {
                name = "tpx1-cover";
                patch = ./tpx1-cover.patch;
            }
        ];
    };

    #sound.extraConfig = ''
    #    options snd-hda-intel model=laptop-dmic
    #'';
    
    services.logind = {
        # properly sleep on lid close
        lidSwitchDocked = "suspend";
    };

    # enable display hidpi
    hardware.video.hidpi.enable = true;

    # enable sensors
    hardware.sensor.iio.enable = true;

    # enable the fingerprint sensor
    services.fprintd.enable = true;
}