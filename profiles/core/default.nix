{ config, lib, pkgs, ... }:
let inherit (lib) fileContents;

in
{
    imports = [ ./security ];

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

    services = {
        gvfs.enable = true;
        fwupd.enable = true;
        earlyoom.enable = true;
    };

    users.mutableUsers = false;

    environment = {
        systemPackages = with pkgs; [
            # general purpose tools
            direnv htop tree jq screen
            psmisc ripgrep zip unzip

            # network tools
            nmap whois curl wget

            # disk partition tools
            cryptsetup dosfstools gptfdisk
            parted fd file ntfs3g

            # low level tools
            binutils coreutils dnsutils
            pciutils iputils moreutils
            utillinux dmidecode
            
            # neovim as text editor
            (neovim.override {
                vimAlias = true;
            })
        ];

        shellAliases = {
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
            nrb = "doas nixos-rebuild";

            # top
            top = "gotop";

            # systemd
            ctl = "systemctl";
            stl = "doas systemctl";
            utl = "systemctl --user";
            ut = "systemctl --user start";
            un = "systemctl --user stop";
            up = "doas systemctl start";
            dn = "doas systemctl stop";
            jtl = "journalctl";

            # ops
            tf = "terraform";
        };
    };

    fonts = {
        fonts = with pkgs; [
            noto-fonts
            (nerdfonts.override { fonts = [
                "FiraCode"
                "FiraMono"
            ]; })
        ];

        fontconfig.defaultFonts = {
            monospace = [ "FiraMono Nerd Font" ];
            sansSerif = [ "Noto Sans" ];
            serif = [ "Noto Serif" ];
        };
    };
}
