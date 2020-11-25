{ pkgs, ... }:
{
    home.packages = with pkgs; [
        dotnet-sdk_3
        omnisharp-roslyn
    ];

    home = {
        sessionVariables = {
            "DOTNET_ROOT" = pkgs.dotnet-sdk_3;
            "MSBuildSDKsPath" = "${pkgs.dotnet-sdk_3}/sdk/${pkgs.dotnet-sdk_3.version}/Sdks";
        };
    };

    programs.vscode.userSettings.omnisharp.path = "/home/alex/.nix-profile/bin/omnisharp";
}