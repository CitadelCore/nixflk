{ lib, pkgs, repos, ... }:
let
    inherit (lib.arnix) mkProfile;
in mkProfile {
    requires.users = [ "alex" ];

    requires.profiles = [
        # root profiles
        "core/ephemeral"
        "core/security/tpm2"
        #"core/security/vpn"
        "core/zfs"
        "graphical"
        "graphical/gnome"
        "graphical/wayland"
        "hardware/system/x1-tablet"
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
                "usbhid"
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
            device = "/dev/disk/by-uuid/F0E0-F1B2";
            fsType = "vfat";
        };
    };

    swapDevices = [{
        device = "/dev/disk/by-partuuid/c06e81a3-b500-4478-984a-840c1eb6395c";
        randomEncryption.enable = true;
    }];

    networking.hostId = "64c49c88";

    environment.systemPackages = with pkgs; [
        gnome3.gnome-tweaks
    ];
}
