{ lib, ... }:
{
    imports = [
        ../users/alex
        ../profiles/comms
        ../profiles/develop
        ../profiles/graphical
        ../profiles/graphical/games
        ../profiles/graphical/media
        ../profiles/graphical/barrier
        ../profiles/graphical/scream
    ];

    boot = {
        initrd = {
            availableKernelModules = [
                "xhci_pci"
                "nvme"
                "usb_storage"
                "usbhid"
                "sd_mod"
                "rtsx_pci_sdmmc"
            ];
            
            kernelModules = [ "dm-snapshot" ];

            # nuke the temporary root volume on boot
            postDeviceCommands = lib.mkAfter ''
                zfs rollback -r rpool/local/root@blank
            '';

            # rm -r /etc/nixos
            # sudo ln -s /home/alex/src/personal/nixflk /etc/nixos
            # touch /etc/NIXOS
        };

        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        tmpOnTmpfs = true;

        kernelModules = [ "kvm-intel" ];
        kernelParams = [
            "zfs.zfs_arc_max=34359738368" # 32 GB max ARC
        ];

        extraModulePackages = [];
        supportedFilesystems = [ "zfs" ];
    };

    networking = {
        networkmanager.enable = true;

        hostId = "68c855d2";
        domain = "stir2.int.arctarus.co.uk";
    };

    fileSystems."/" = {
        device = "rpool/local/root";
        fsType = "zfs";
    };

    fileSystems."/nix" = {
        device = "rpool/local/nix";
        fsType = "zfs";
    };

    fileSystems."/home" = {
        device = "rpool/safe/home";
        fsType = "zfs";
    };

    fileSystems."/persist" = {
        device = "rpool/safe/persist";
        fsType = "zfs";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/59A0-1D42";
        fsType = "vfat";
    };

    swapDevices = [];
    powerManagement.cpuFreqGovernor = "powersave";

    nixpkgs.config.allowUnfree = true;

    networking.useDHCP = false;
    networking.interfaces.enp0s31f6.useDHCP = true;
    networking.interfaces.ens4u2u1u2c2.useDHCP = true;
    networking.interfaces.wlp0s20f3.useDHCP = true;

    services = {
        xserver.videoDrivers = [ "modesetting" "nvidia" ];
        fwupd.enable = true;
        
        zfs = {
            trim.enable = true;
            autoScrub.enable = true;
            #autoSnapshot.enable = true;
        };
    };

    hardware = {
        # Disabled until NVIDIA fixes external monitor support...
        # nvidia.prime = {
        #     offload.enable = true;
        #     intelBusId = "PCI:0:2:0";
        #      nvidiaBusId = "PCI:1:0:0";
        # };

        enableRedistributableFirmware = true;
    };
    
    system.stateVersion = "20.09";
}
