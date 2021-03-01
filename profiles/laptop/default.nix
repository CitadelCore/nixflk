{ config, pkgs, lib, ... }:
{
    imports = [ ../personal ];

    environment.systemPackages = with pkgs; [
        # power management
        acpi lm_sensors
        
        # utilities
        pciutils usbutils v4l-utils
        wirelesstools i2c-tools

        # libraries
        libcamera

        # support calls
        calls
    ];

    boot = {
        kernelModules = [ "acpi_call" ];
        extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    };

    hardware.bluetooth.enable = true;
    programs.light.enable = true; # todo: needed outside i3?
    networking.domain = "mobile.arctarus.net";

    services = {
        # better timesync for unstable internet connections
        chrony.enable = true;
        timesyncd.enable = true;

        # power management
        tlp = {
            enable = true;
            settings = {
                "CPU_SCALING_GOVERNOR_ON_AC" = "performance";
                "CPU_SCALING_GOVERNOR_ON_BAT" = "powersave";
                "CPU_HWP_ON_AC" = "performance";
                "CPU_HWP_ON_BAT" = "power";

                "ENERGY_PERF_POLICY_ON_AC" = "performance";
                "ENERGY_PERF_POLICY_ON_BAT" = "power";

                "USB_BLACKLIST_PRINTER" = 1;
                "USB_BLACKLIST_WWAN" = 1;
            };
        };

        thermald.enable = true;
    };
}