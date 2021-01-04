{ pkgs, ... }:
{
    home.packages = with pkgs; [ go delve ];
    programs.vscode.userSettings.go.useLanguageServer = true;
}