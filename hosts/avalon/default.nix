{ lib, pkgs, repos, ... }:
let
    inherit (lib.arnix) mkProf;
in {
    imports = (with repos.root; mkProf [
        profiles.core.ephemeral
        profiles.core.security.tpm
        #profiles.core.security.vpn
        profiles.core.zfs
        profiles.locales.gb
        profiles.virt.docker
        profiles.virt.libvirt
        profiles.graphical
        profiles.graphical.gnome
        profiles.graphical.wayland
    ]) ++ (with repos.self; mkProf [
        users.alex
        profiles.laptop
        profiles.hardware.system.x1-tablet
    ]);

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
