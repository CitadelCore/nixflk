{
    programs = {
        fish = {
            enable = true;

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
                lh = "ls -lah";
                hgrep = "cat ~/.bash_history | grep $argv";

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

            shellInit = ''
                set -x XDG_DATA_DIRS "$HOME/.nix-profile/share:$XDG_DATA_DIRS"
                set -x EDITOR vim
                set -x TERM xterm
            '';
        };

        direnv = {
            enable = true;
            enableFishIntegration = true;
            enableNixDirenvIntegration = true;
        };
    };
}