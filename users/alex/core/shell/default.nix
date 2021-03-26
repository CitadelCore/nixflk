{ pkgs, ... }:
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

                # top
                top = "gotop";

                # systemd
                ctl = "systemctl";
                stl = "sudo systemctl";
                utl = "systemctl --user";
                ut = "systemctl --user start";
                un = "systemctl --user stop";
                up = "sudo systemctl start";
                dn = "sudo systemctl stop";
                jtl = "journalctl";

                # ops
                tf = "terraform";
            };

            shellInit = ''
                set -x UID (id -u)
                set -x EDITOR vim
                set -x TERM xterm

                set -x XDG_DATA_DIRS "$HOME/.nix-profile/share:$XDG_DATA_DIRS"
                set -x SSH_AUTH_SOCK "/run/user/$UID/gnupg/S.gpg-agent.ssh"
            '';

            plugins = with pkgs; [
                {
                    # for bash script compatibility
                    name = "bass";
                    src = fetchFromGitHub {
                        owner = "edc";
                        repo = "bass";
                        rev = "df4a1ebf8c0536e4bd7b7828a4c0dcb2b7b5d22b";
                        sha256 = "1dgydrza6lvx3dl9spkla1g728x5rr76mqrwk2afrl732439y6jl";
                    };
                }
            ];
        };

        direnv = {
            enable = true;
            enableFishIntegration = true;
            enableNixDirenvIntegration = true;
        };
    };
}