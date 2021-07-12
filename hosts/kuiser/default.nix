{ lib, pkgs, repos, ... }:
let
    inherit (lib.kuiser) mkProfile;
in mkProfile {
    imports = [
        ./wireguard.nix
    ];

    requires.users = [ "alex" ];

    requires.profiles = [
        # root profiles
        "core/ephemeral"
        "core/security/sshd"
        "core/security/tpm2"
        #"core/security/vpn"
        "core/zfs"
        "graphical"
        "graphical/plasma5"
        "hardware/system/p72"
        "locales/gb"
        "roles/dev"
        "roles/personal"
        "virt/docker"
        "virt/libvirt"

        # local profiles
        "graphical/games"
        "graphical/scream"
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
            "2a10:4a80:7:8::10" = [ "vault1.stir1.arctarus.net" ];
        };
    };

    services = {
        # dock is not properly detected as a dock
        # so lid switch on external power must be ignored
        logind.lidSwitchExternalPower = "ignore";

        # disable display blanking, as it really breaks the external monitors
        # (better option than just disabling DPMS completely)
        xserver.serverFlagsSection = ''
            Option "BlankTime" "0"
            Option "StandbyTime" "0"
            Option "SuspendTime" "0"
            Option "OffTime" "0"
        '';
    };
    
    # use UK keyboard layout
    console.keyMap = lib.mkDefault "uk";
    services.xserver.layout = lib.mkDefault "gb";

    system.stateVersion = "20.09";
}
