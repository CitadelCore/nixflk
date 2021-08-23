{ config, lib, pkgs, host, ... }:

let
    my = import ./my.nix { inherit host; };
in
{
    _module.args = { inherit my; };

    home-manager = {
        users."${my.username}" = import ./home.nix;
    };

    users.users."${my.username}" = {
        uid = 1000;
        isNormalUser = true;

        description = my.name;
        extraGroups = [
            "adbusers"
            "docker"
            "libvirtd"
            "networkmanager"
            "sysconf"
            "video"
            "wheel"
        ];

        shell = pkgs.fish;
        hashedPassword = lib.fileContents ./password.txt;
        openssh.authorizedKeys.keyFiles = [ ./sshkey.txt ];
    };
}
