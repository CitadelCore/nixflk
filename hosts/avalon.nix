{ lib, pkgs, nixos-hardware, ... }:
[
    # hardware modules
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    nixos-hardware.nixosModules.common-cpu-intel-kaby-lake

    # main module
    {
        _module.args.host = "avalon";

        imports = [
            ../users/alex
            ../profiles/core/ephemeral
            ../profiles/core/security/tpm
            ../profiles/develop
            ../profiles/graphical
            ../profiles/graphical/wayland
            ../profiles/laptop
            ../profiles/hardware/x1-tablet
            ../profiles/locales/gb
            #../profiles/virt/docker
            #../profiles/virt/libvirt
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
                device = "rpool/local/docker";
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
                device = "/dev/disk/by-uuid/F0E0-F1B2";
                fsType = "vfat";
            };
        };

        swapDevices = [{
            device = "/dev/disk/by-partuuid/c06e81a3-b500-4478-984a-840c1eb6395c";
            randomEncryption.enable = true;
        }];

        networking = {
            hostId = "64c49c88";
            domain = "mobile.arctarus.net";

            useDHCP = false;
            networkmanager.enable = true;

            interfaces.wlp4s0.useDHCP = true;
        };

        services.xserver = {
            displayManager.gdm.enable = true;
            desktopManager.gnome3.enable = true;
        };

        environment.systemPackages = with pkgs; [
            gnome3.gnome-tweaks
        ];
        
        hardware.enableRedistributableFirmware = true;
    }
]
