{ pkgs, ... }:
let
    packages = p: with p; [ ];
    python = pkgs.python3Full.withPackages packages;
in
{
    home.packages = with pkgs; [ python conda ];
    programs.vscode.userSettings.python = {
        languageServer = "Pylance";
    };
}