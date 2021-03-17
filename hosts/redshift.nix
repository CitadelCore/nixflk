{ lib, pkgs, users, profiles, ... }:
{
    imports = lib.arnix.mkProf [
        users.alex
        profiles.core.ephemeral
        profiles.core.security.tpm
        profiles.core.zfs
        profiles.graphical
        profiles.graphical.wayland
        profiles.laptop
        profiles.hardware.system.p15v
        profiles.locales.gb
        profiles.virt.docker
        profiles.virt.libvirt
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

    networking.hostId = "b72a26e5";

    # stuff below here should probably be
    # moved out to a common "gdm/gnome" profile
    services.xserver = {
        displayManager.gdm.enable = true;
        desktopManager.gnome3.enable = true;
    };

    services.gnome3.chrome-gnome-shell.enable = true;

    environment.systemPackages = with pkgs; [
        gnome3.gnome-tweaks
    ];
}
