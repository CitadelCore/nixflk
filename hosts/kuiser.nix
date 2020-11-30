{ lib, pkgs, ... }:
{
    imports = [
        ../users/alex
        ../profiles/core/ephemeral
        ../profiles/core/security/tpm
        ../profiles/develop
        ../profiles/graphical
        ../profiles/graphical/games
        ../profiles/graphical/barrier
        ../profiles/graphical/scream
        ../profiles/laptop
        ../profiles/virt/docker
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

    fileSystems = {
        "/" = {
            device = "rpool/local/root";
            fsType = "zfs";
        };

        "/nix" = {
            device = "rpool/local/nix";
            fsType = "zfs";
        };

        "/var/lib/docker" = {
            device = "rpool/safe/docker";
            fsType = "zfs";
        };

        "/home" = {
            device = "rpool/safe/home";
            fsType = "zfs";
        };

        "/persist" = {
            device = "rpool/safe/persist";
            fsType = "zfs";
        };

        "/boot" = {
            device = "/dev/disk/by-uuid/59A0-1D42";
            fsType = "vfat";
        };
    };

    # we have enough memory we definitely don't need swap!
    swapDevices = [];

    networking = {
        hostId = "68c855d2";
        domain = "stir2.int.arctarus.co.uk";

        useDHCP = false;
        networkmanager.enable = true;

        interfaces = {
            enp0s31f6.useDHCP = true;
            ens4u2u1u2c2.useDHCP = true;
            wlp0s20f3.useDHCP = true;

            wg0.mtu = 1280;
        };

        wireguard = {
            enable = true;

            # This is the fallback link to Helios Stirling (stir1)
            # It is the backdoor to Arctarus infrastructure should any RIS components fail
            interfaces.wg0 = {
                listenPort = 51592;
                ips = [ "10.8.16.15/32" "2a10:4a80:7:16::15/64" ];
                privateKeyFile = "/persist/nixos/secrets/wireguard/kuiser/wg0.txt";

                peers = [{
                    endpoint = "81.145.136.67:51820";
                    publicKey = "lna4F7/fJrC0DzOm6Dx3ggqx/smJ1/2faWQvLhr88Qs=";
                    persistentKeepalive = 25; # we're mobile so almost certainly behind NAT

                    allowedIPs = [
                        "10.60.10.0/24"
                        "208.64.203.133/32" # Valve's Perforce server
                        "2a10:4a80:7:8::1/128"
                        "2a10:4a80:7:8::10/128"
                        "2a10:4a80:7:8::30/128"
                    ];
                }];
            };
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
            autoSnapshot.enable = true;
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

    # enable nvidia support for Docker as we have a nvidia card
    # also make it use our ZFS pool for storage
    virtualisation.docker = {
        enableNvidia = true;
        storageDriver = "zfs";
    };

    # enable dev docs
    documentation.dev.enable = true;
    console.useXkbConfig = true;

    system.stateVersion = "20.09";
}
