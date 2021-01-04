{ pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            #ms-dotnettools.csharp
            ms-azuretools.vscode-docker
            #ms-python.vscode-pylance
            #ms-toolsai.jupyter

            golang.Go
            bbenoist.Nix
            #arrterian.nix-env-selector
            #brettm12345.nixfmt-vscode

            #timonwong.shellcheck
        ];

        userSettings = {
            workbench.colorTheme = "Visual Studio 2019 Dark";
            editor.fontLigatures = true;
        };
    };
}