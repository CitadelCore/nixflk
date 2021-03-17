{ pkgs, ... }:
let
    package = with pkgs; (with dotnetCorePackages; combinePackages [ sdk_2_1 sdk_3_0 sdk_3_1 sdk_5_0 ]);
in
{
    home = {
        packages = with pkgs; [ package omnisharp-roslyn ];

        sessionVariables = let
            sdkPath = "${package}/sdk/${package.version}";
        in
        {
            "DOTNET_ROOT" = package;
            #"MSBuildSDKsPath" = "${sdkPath}/Sdks";
        };
    };

    programs.vscode.userSettings.omnisharp = {
        path = "${pkgs.omnisharp-roslyn}/bin/omnisharp";
        useGlobalMono = "never";
    };
}