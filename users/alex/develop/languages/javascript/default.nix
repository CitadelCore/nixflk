{
    home = {
        sessionPath = [ "\${HOME}/.npm-packages/bin" ];
        sessionVariables = {
            "NPM_PACKAGES" = "$HOME/.npm-packages";
            "MANPATH" = "$HOME/.npm-packages/share/man";
        };

        # TODO: don't hardcode the username here
        file.".npmrc".text = ''
            prefix=/home/alex/.npm-packages
        '';
    };
}