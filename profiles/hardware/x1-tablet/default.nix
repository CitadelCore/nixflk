{ pkgs, ... }:
{
    boot = {
        extraModprobeConfig = ''
            options thinkpad_acpi fan_control=1 experimental=1
        '';

        # we're hidpi so use lower res for boot
        loader.systemd-boot.consoleMode = "1";

        # use latest stable kernel version
        kernelPackages = pkgs.linuxPackages_5_10;
        kernelPatches = [
            {
                name = "tpx1-cover";
                patch = ./tpx1-cover.patch;
            }
            # {
            #     name = "ov8858-camera";
            #     patch = ./ov8858-camera.patch;
            #     extraConfig = ''
            #         PMIC_OPREGION y
            #         STAGING_MEDIA y
            #         INTEL_ATOMISP y
            #         VIDEO_ATOMISP m
            #         VIDEO_ATOMISP_IMX m
            #         VIDEO_ATOMISP_OV8858 m
            #         VIDEO_ATOMISP_MSRLIST_HELPER m
            #         VIDEO_IPU3_IMGU m
            #     '';
            # }
        ];

        # enable this block for kernel module iteration
        # must build with i.e `sudo ./cursed-rebuild switch --impure`
        # kernelPackages = let kernel = (pkgs.linuxManualConfig {
        #     inherit (pkgs) stdenv;
        #     version = "5.9.0";

        #     src = /home/alex/src/external/kernel/linux;
        #     configfile = /home/alex/src/external/kernel/kernel.conf;
        #     allowImportFromDerivation = true;
        # }); in pkgs.linuxPackagesFor kernel;
    };

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

        # undervolt cpu and igpu
        # units are in mV (milivolts)
        undervolt = {
            enable = true;
            coreOffset = -95;
            gpuOffset = -48;
        };
    };
}