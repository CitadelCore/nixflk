{ pkgs, ... }:
let
    package = pkgs.dotnet-sdk_5;
in
{
    home = {
        packages = with pkgs; [ package omnisharp-roslyn ];

        sessionVariables = let
            sdkPath = "${package}/sdk/${package.version}";
        in
        {
            "DOTNET_ROOT" = package;
            "MSBuildSDKsPath" = "${sdkPath}/Sdks";
        };
    };

    programs.vscode.userSettings.omnisharp = {
        path = "${pkgs.omnisharp-roslyn}/bin/omnisharp";
        useGlobalMono = "never";
    };
}