{ pkgs, ... }:
{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            # first party extensions
            ms-vscode.cpptools
            ms-dotnettools.csharp
            ms-azuretools.vscode-docker
            ms-python.python
            ms-python.vscode-pylance
            #ms-toolsai.jupyter

            # official language support
            bbenoist.Nix
            golang.Go
            #rust-lang.rust
            hashicorp.terraform

            # third party extensions
            #arrterian.nix-env-selector
            brettm12345.nixfmt-vscode
            #timonwong.shellcheck
        ];

        userSettings = {
            editor.fontLigatures = true;

            workbench = {
                colorTheme = "Visual Studio 2019 Dark";
                editorAssociations = [{
                    viewType = "jupyter.notebook.ipynb";
                    filenamePattern = "*.ipynb";
                }];
            };
        };
    };
}