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

    hardware = {
        video.hidpi.enable = true;
        sensor.iio.enable = true;
        usbWwan.enable = true;
    };

    services = {
        fprintd.enable = true;
        neard.enable = true;

        # gpsd = {
        #     enable = true;
        #     device = "/dev/ttyUSB1";
        # };

        logind = {
            # properly sleep on lid close
            lidSwitchDocked = "suspend";
        };
    };
}