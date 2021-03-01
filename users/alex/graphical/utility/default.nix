{ pkgs, ... }:
{
    home.packages = with pkgs; [
        _1password _1password-gui
        virt-manager gpsd

        # allow running windows programs
        wineWowPackages.stable
    ];
}