{ config, lib, ... }:
{
    home-manager = {
        users.alex = {
            imports = [
                ./core
                ./develop
                ./graphical
            ];

            # bring our package overlays in from the machine
            nixpkgs = { inherit (config.nixpkgs) overlays; };
        };
    };

    users.users.alex = {
        uid = 1000;
        isNormalUser = true;

        description = "Alex Zero";
        extraGroups = [ "wheel" "networkmanager" "docker" ];

        hashedPassword = lib.fileContents ../../secrets/passwords/alex.txt;
        openssh.authorizedKeys.keyFiles = [ ./sshkey.txt ];
    };
}
