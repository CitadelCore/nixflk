{ lib, pkgs, ... }:
{
    _module.args.host = "avalon";

    imports = [
        ../users/alex
        ../profiles/core/ephemeral
        ../profiles/core/security/tpm
        ../profiles/develop
        ../profiles/graphical
        ../profiles/graphical/games
        ../profiles/laptop
        ../profiles/locales/gb
        ../profiles/virt/docker
        ../profiles/virt/libvirt
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

    swapDevices = [""];

    networking = {
        hostId = "9aefe563";
        domain = "mobile.arctarus.net";
        networkmanager.enable = true;
    };

    services = {
        xserver = {
            displayManager.gdm = {
                enable = true;
                wayland = true;
            };

            desktopManager.gnome3.enable = true;
        };

        zfs = {
            trim.enable = true;
            autoScrub.enable = true;
            autoSnapshot.enable = true;
        };
    };
    
    hardware.enableRedistributableFirmware = true;
}