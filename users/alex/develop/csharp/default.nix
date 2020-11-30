{ pkgs, ... }:
{
    home.packages = with pkgs; [
        dotnet-sdk_3
        omnisharp-roslyn
    ];

    home = {
        sessionVariables = let
            sdkPath = "${pkgs.dotnet-sdk_3}/sdk/${pkgs.dotnet-sdk_3.version}";
        in {
            "DOTNET_ROOT" = pkgs.dotnet-sdk_3;
            "MSBuildSDKsPath" = "${sdkPath}/Sdks";
        };
    };

    programs.vscode.userSettings.omnisharp.loggingLevel = "trace";
    programs.vscode.userSettings.omnisharp.path = "/home/alex/.nix-profile/bin/omnisharp";
}