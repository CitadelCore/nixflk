{ pkgs, ... }:
{
    imports = [
        ./pam.nix
        ./smartcard.nix
    ];

    programs.ssh.startAgent = true;

    environment.systemPackages = with pkgs; [
        _1password _1password-gui
    ];
}