{ config, lib, pkgs, name, ... }:

let
    # switch name depending on whether
    # this is a work machine or not (to avoid confusion)
    role = if name == "redshift" then "work" else "personal";
    my = import ./my.nix { inherit role; };
in
{
    _module.args = { inherit my; };

    home-manager = {
        users."${my.username}" = {
            imports = [
                ../../modules/home

                ./core
                ./develop
                ./graphical
            ]

            # add host specific user configuration
            ++ (if name != null then [(./hosts + "/${name}")] else []);

            # inherit the user meta configuration
            _module.args = { inherit my; };
        };
    };

    users.users."${my.username}" = {
        uid = 1000;
        isNormalUser = true;

        description = my.name;
        extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "video" "sysconf" ];

        shell = pkgs.fish;
        hashedPassword = lib.fileContents ./password.txt;
        openssh.authorizedKeys.keyFiles = [ ./sshkey.txt ];
    };
}
