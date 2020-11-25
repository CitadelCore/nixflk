{ config, lib, pkgs, ... }:
{
    imports = [
        ./clang
        ./csharp
        ./golang
        ./java
        ./python
    ];

    programs.vscode = {
        enable = true;
        userSettings = {
            workbench.colorTheme = "Visual Studio 2019 Dark";
            editor.fontLigatures = true;
        };
    };
}