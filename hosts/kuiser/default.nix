{ lib, pkgs, repos, ... }:
let
    inherit (lib.arnix) mkProf;
in {
    imports = (with repos.root; mkProf [
        profiles.core.ephemeral
        profiles.core.security.tpm
        profiles.core.security.sshd
        #profiles.core.security.vpn
        profiles.core.zfs
        profiles.locales.gb
        profiles.virt.docker
        profiles.virt.libvirt
    ]) ++ (with repos.self; mkProf [
        users.alex
        profiles.graphical
        profiles.graphical.games
        profiles.graphical.scream
        profiles.laptop
        profiles.hardware.system.p72
    ]) ++ [
        ./wireguard.nix
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
        kernelParams = [
            "zfs.zfs_arc_max=34359738368" # 32 GB max ARC
        ];
    };

    fileSystems = {
        "/var/lib/docker" = {
            device = "rpool/safe/docker";
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

        # allow Barrier
        firewall.allowedTCPPorts = [ 24800 ];

        hosts = {
            "2a10:4a80:7:8::30" = [ "deployer.stir1.arctarus.net" ];
            "2a10:4a80:7:8::10" = [ "vault1.stir1.arctarus.net" ];
        };
    };

    services = {
        autorandr.enable = true;

        # dock is not properly detected as a dock
        # so lid switch on external power must be ignored
        logind.lidSwitchExternalPower = "ignore";

        xserver = {
            # disable display blanking, as it really breaks the external monitors
            # (better option than just disabling DPMS completely)
            serverFlagsSection = ''
                Option "BlankTime" "0"
                Option "StandbyTime" "0"
                Option "SuspendTime" "0"
                Option "OffTime" "0"
            '';

            displayManager.lightdm.enable = true;
            windowManager.i3.enable = true;
        };
    };

    # enable dev docs
    documentation.dev.enable = true;
    
    # use UK keyboard layout
    console.keyMap = lib.mkDefault "uk";
    services.xserver.layout = lib.mkDefault "gb";

    system.stateVersion = "20.09";
}
