{ lib, pkgs, repos, ... }:
let
    inherit (lib.kuiser) mkProfile;
in mkProfile {
    requires.users = [ "alex" ];

    requires.profiles = [
        # root profiles
        "core/ephemeral"
        "core/security/tpm2"
        "core/zfs"
        "graphical"
        "graphical/gnome"
        "graphical/wayland"
        "hardware/system/p15v"
        "locales/gb"
        "roles/dev"
        "roles/personal"
        "virt/docker"
        "virt/libvirt"

        # local profiles
        "laptop"
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

    environment.systemPackages = with pkgs; [
        gnome3.gnome-tweaks
    ];
}
