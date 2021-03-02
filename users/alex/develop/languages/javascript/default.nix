{ meta, ... }:
{
    home = {
        sessionPath = [ "\${HOME}/.npm-packages/bin" ];
        sessionVariables = {
            "NPM_PACKAGES" = "$HOME/.npm-packages";
            "MANPATH" = "$HOME/.npm-packages/share/man";
        };

        file.".npmrc".text = ''
            prefix=/home/${meta.username}/.npm-packages
        '';
    };
}