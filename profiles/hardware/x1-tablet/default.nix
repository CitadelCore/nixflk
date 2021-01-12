{ pkgs, ... }:
{
    boot = {
        # we're hidpi so use lower res for boot
        loader.systemd-boot.consoleMode = "1";

        # use latest kernel version
        kernelPackages = pkgs.linuxPackages_5_9;
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

    # properly sleep on lid close
    services.logind.lidSwitchDocked = "suspend";

    # enable sensors
    hardware.sensor.iio.enable = true;

    # enable the fingerprint sensor
    services.fprintd.enable = true;
}