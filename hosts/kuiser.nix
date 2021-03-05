{ lib, pkgs, nixos-hardware, ... }:
[
    # hardware modules
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    nixos-hardware.nixosModules.common-cpu-intel-kaby-lake

    # main module
    {
        _module.args.host = "kuiser";

        imports = [
            ../users/alex
            ../profiles/core/ephemeral
            ../profiles/core/security/tpm
            ../profiles/core/security/sshd
            #../profiles/core/security/vpn
            ../profiles/core/zfs
            ../profiles/develop
            ../profiles/graphical
            ../profiles/graphical/games
            ../profiles/graphical/scream
            ../profiles/laptop
            ../profiles/hardware/system/p72
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

            # wireguard = {
            #     enable = true;

            #     # This is the fallback link to Helios Stirling (stir1)
            #     # It is the backdoor to Arctarus infrastructure should any RIS components fail
            #     interfaces.wg0 = {
            #         mtu = 1420;
            #         listenPort = 51592;
            #         ips = [ "10.8.16.15/32" "2a10:4a80:7:16::15/64" ];
            #         privateKeyFile = "/persist/nixos/secrets/wireguard/kuiser/wg0.txt";

            #         peers = [{
            #             endpoint = "81.145.136.67:51820";
            #             publicKey = "lna4F7/fJrC0DzOm6Dx3ggqx/smJ1/2faWQvLhr88Qs=";
            #             persistentKeepalive = 25; # we're mobile so almost certainly behind NAT

            #             allowedIPs = [
            #                 "10.60.10.0/24"
            #                 "208.64.203.133/32" # Valve's Perforce server
            #                 "2a10:4a80:7:8::1/128"
            #                 "2a10:4a80:7:8::10/128"
            #                 "2a10:4a80:7:8::30/128"
            #             ];
            #         }];
            #     };
            # };
        };

        services = {
            autorandr.enable = true;
            hardware.bolt.enable = true;

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

        hardware.enableRedistributableFirmware = true;

        environment.systemPackages = with pkgs; [
            gnome3.eog
            gnome3.nautilus
            gnome3.file-roller
            libnotify networkmanagerapplet
        ];

        # enable dev docs
        documentation.dev.enable = true;
        
        # use UK keyboard layout
        console.keyMap = lib.mkDefault "uk";
        services.xserver.layout = lib.mkDefault "gb";

        system.stateVersion = "20.09";
    }
]
