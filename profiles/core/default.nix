{ config, lib, pkgs, ... }:
let inherit (lib) fileContents;

in
{
    imports = [
        ./security/pam.nix
        ./security/smartcard.nix
        ../../local/locale.nix
    ];

    nix = {
        package = pkgs.nixFlakes;
        systemFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];

        autoOptimiseStore = true;
        gc.automatic = true;
        optimise.automatic = true;
        useSandbox = true;
        allowedUsers = [ "@wheel" ];
        trustedUsers = [ "root" "@wheel" ];

        extraOptions = ''
            experimental-features = nix-command flakes ca-references
            min-free = 536870912
        '';
    };

    security = {
        # install the Arctarus Root CA
        pki.certificateFiles = [ ./root.pem ];

        hideProcessInformation = true;
        protectKernelImage = true;
    };

    services.earlyoom.enable = true;
    users.mutableUsers = false;

    environment = {
        systemPackages = with pkgs; [
            binutils
            coreutils
            cryptsetup
            curl
            direnv
            dnsutils
            dosfstools
            fd
            file
            gotop
            gptfdisk
            iputils
            jq
            moreutils
            nmap
            parted
            ripgrep
            tree
            utillinux
            vault
            vim
            whois
            wget
        ];

        variables = {
            "HISTIGNORE" = "&:vault*";
        };

        shellAliases =
        let ifSudo = lib.mkIf config.security.sudo.enable;
        in
        {
            # quick cd
            ".." = "cd ..";
            "..." = "cd ../..";
            "...." = "cd ../../..";
            "....." = "cd ../../../..";

            # git
            g = "git";

            # grep
            grep = "rg";
            gi = "grep -i";

            # internet ip
            myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

            # nix
            n = "nix";
            np = "n profile";
            ni = "np install";
            nr = "np remove";
            ns = "n search --no-update-lock-file";
            nf = "n flake";
            srch = "ns nixpkgs";
            nrb = ifSudo "sudo nixos-rebuild";

            # sudo
            s = ifSudo "sudo -E ";
            si = ifSudo "sudo -i";
            se = ifSudo "sudoedit";

            # top
            top = "gotop";

            # systemd
            ctl = "systemctl";
            stl = ifSudo "s systemctl";
            utl = "systemctl --user";
            ut = "systemctl --user start";
            un = "systemctl --user stop";
            up = ifSudo "s systemctl start";
            dn = ifSudo "s systemctl stop";
            jtl = "journalctl";
        };
    };

    fonts = {
        fonts = with pkgs; [ nerdfonts ];

        fontconfig.defaultFonts = {
            monospace = [ "FiraMono Nerd Font" ];
            sansSerif = [ "FiraCode Nerd Font" ];
        };
    };
}
