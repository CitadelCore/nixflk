{ config, lib, pkgs, name, ... }:

let
    # switch name depending on whether
    # this is a work machine or not (to avoid confusion)
    work = name == "redshift";
    meta = if work then {
        role = "work";
        name = "Joseph Marsden";
        email = "joseph.marsden@speech-graphics.com";
        username = "jmarsden";
    } else {
        role = "personal";
        name = "Alex Zero";
        email = "joseph@marsden.space";
        username = "alex";
    };
in
{
    _module.args.meta = meta;

    home-manager = {
        users."${meta.username}" = {
            imports = [
                ../../modules/home

                ./core
                ./develop
                ./graphical
            ]

            # add host specific user configuration
            ++ (if name != null then [(./hosts + "/${name}")] else []);

            # inherit the user meta configuration
            _module.args.meta = meta;
        };
    };

    users.users."${meta.username}" = {
        uid = 1000;
        isNormalUser = true;

        description = meta.name;
        extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "video" "sysconf" ];

        shell = pkgs.fish;
        hashedPassword = lib.fileContents ../../secrets/passwords/alex.txt;
        openssh.authorizedKeys.keyFiles = [ ./sshkey.txt ];
    };
}
