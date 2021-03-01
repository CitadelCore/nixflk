{ lib, pkgs, nixos-hardware, ... }:
[
    # hardware modules
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    nixos-hardware.nixosModules.common-cpu-intel-kaby-lake

    # main module
    {
        _module.args.host = "redshift";

        imports = [
            ../users/alex
            ../profiles/core/ephemeral
            ../profiles/core/security/tpm
            ../profiles/develop
            ../profiles/graphical
            ../profiles/graphical/wayland
            ../profiles/laptop
            ../profiles/hardware/p15v
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
                    "sd_mod"
                    "rtsx_pci_sdmmc"
                ];
                
                kernelModules = [ "dm-snapshot" ];
            };

            loader.efi.canTouchEfiVariables = true;
            kernelModules = [ "kvm-intel" ];
        };

        fileSystems = {
            "/var/lib/docker" = {
                device = "rpool/local/docker";
                fsType = "zfs";
            };

            "/boot" = {
                device = "/dev/disk/by-uuid/0ECD-3BA9";
                fsType = "vfat";
            };
        };

        swapDevices = [{
            device = "/dev/disk/by-partuuid/98e7dbe7-570e-4876-9d03-608e032f1a01";
            randomEncryption.enable = true;
        }];

        networking = {
            hostId = "b72a26e5";
            domain = "mobile.arctarus.net";

            useDHCP = false;
            networkmanager.enable = true;

            interfaces = {
                enp0s31f6.useDHCP = true;
                wlp0s20f3.useDHCP = true;
            };
        };

        # stuff below here should probably be
        # moved out to a common "gdm/gnome" profile
        services.xserver = {
            displayManager.gdm.enable = true;
            desktopManager.gnome3.enable = true;
        };

        services.udisks2.enable = true;
        services.gnome3.chrome-gnome-shell.enable = true;

        environment.systemPackages = with pkgs; [
            gnome3.gnome-tweaks
        ];
        
        hardware.enableRedistributableFirmware = true;
    }
]
