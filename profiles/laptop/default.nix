{ config, pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
        acpi lm_sensors wirelesstools pciutils usbutils
    ];

    hardware.bluetooth.enable = true;
    programs.light.enable = true;

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
            };
        };

        thermald.enable = true;
    };
}