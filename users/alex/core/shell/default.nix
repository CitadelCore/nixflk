{
    programs = {
        fish = {
            enable = true;

            shellAliases = {
                "lh" = "ls -lah";
                "hgrep" = "cat ~/.bash_history | grep $argv";
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