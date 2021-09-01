{ pkgs, my, ... }:
{
    home = let
        goPath = "/home/${my.username}/go";
    in {
        sessionPath = [ "${goPath}/bin" ];
        sessionVariables."GOPATH" = goPath;
        packages = with pkgs; [ go delve ];
    };

    programs.vscode.userSettings.go.useLanguageServer = true;
}
