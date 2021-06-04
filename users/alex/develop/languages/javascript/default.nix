{ my, ... }:
{
    home = {
        sessionPath = [ "\${HOME}/.npm-packages/bin" ];
        sessionVariables = {
            "NPM_PACKAGES" = "$HOME/.npm-packages";

            # TODO: fix this, this breaks the system-wide manpages
            # "MANPATH" = "$HOME/.npm-packages/share/man";
        };

        file.".npmrc".text = ''
            prefix=/home/${my.username}/.npm-packages
        '';
    };
}