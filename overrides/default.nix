{
    # allowed unfree packages
    unfree = [
        "1password" "postman"
        "pycharm-professional" "clion" "webstorm"

        "vscode"
        "vscode-extension-ms-vscode-cpptools"
        "vscode-extension-ms-toolsai-jupyter"
        "vscode-extension-MS-python-vscode-pylance"

        "chromium" "chromium-unwrapped"
        "chrome-widevine-cdm" "google-chrome"

        "spotify" "spotify-unwrapped"
        "discord" "slack" "zoom"
    ];

    packages = [(pkgs: final: prev: with pkgs; {
        # packages pulled from upstream
        inherit tanka kubie kubectx;
    })];
}