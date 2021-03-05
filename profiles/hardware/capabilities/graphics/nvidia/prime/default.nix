{ pkgs, ... }:
{
    hardware.nvidia.prime = {
        offload.enable = true;
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
    };

    services.xserver.displayManager.setupCommands = ''
        # External monitor support via Output Sink
        ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource NVIDIA-G0 modesetting
    '';
}