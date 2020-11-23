{ lib, pkgs, ... }:
{
    imports = [
        ../users/alex
        ../profiles/comms
        ../profiles/develop
        ../profiles/graphical
        ../profiles/graphical/creative
        ../profiles/graphical/games
        ../profiles/graphical/media
        ../profiles/graphical/barrier
        ../profiles/graphical/scream
        ../profiles/laptop
        ../profiles/sysadmin
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

    # link the config in the persistent volume to the temporary volume
    system.activationScripts.linkNixos = {
        text = ''
            rm -rf /etc/nixos
            ln -s /persist/nixos /etc/nixos
        '';

        deps = [];
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

    # we have enough memory we definitely don't need swap!
    swapDevices = [];

    networking = {
        useDHCP = false;
        interfaces = {
            enp0s31f6.useDHCP = true;
            ens4u2u1u2c2.useDHCP = true;
            wlp0s20f3.useDHCP = true;
        };
    };

    services = {
        fwupd.enable = true;
        autorandr.enable = true;

        # dock is not properly detected as a dock
        # so lid switch on external power must be ignored
        logind.lidSwitchExternalPower = "ignore";

        xserver = {
            layout = "gb";
            videoDrivers = [ "modesetting" "nvidia" ];

            # disable display blanking, as it really breaks the external monitors
            # (better option than just disabling DPMS completely)
            serverFlagsSection = ''
                Option "BlankTime" "0"
                Option "StandbyTime" "0"
                Option "SuspendTime" "0"
                Option "OffTime" "0"
            '';
        };
        
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
        #     nvidiaBusId = "PCI:1:0:0";
        # };

        enableRedistributableFirmware = true;
    };

    console.useXkbConfig = true;
    system.stateVersion = "20.09";
}
