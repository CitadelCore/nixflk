{ pkgs, ... }:
{
    imports = [ ./vscode ];

    home.packages = with pkgs; [
        jetbrains.clion
        (jetbrains.idea-community.override { jdk = jetbrains.jdk; })
        jetbrains.webstorm
        jetbrains.pycharm-professional
    ];
}
