{ pkgs, ... }:
{
    home.packages = with pkgs; [
        _1password _1password-gui
        virt-manager gpsd

        # convenience utilities for yubikey
        yubikey-manager
        yubikey-manager-qt
        yubikey-personalization
        yubikey-personalization-gui
        yubioath-desktop
        yubico-piv-tool

        # allow running windows programs
        wineWowPackages.stable
    ];
}