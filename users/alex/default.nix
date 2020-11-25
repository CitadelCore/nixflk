{ config, lib, ... }:
{
    home-manager = {
        users.alex = {
            imports = [
                ../profiles/core
                ../profiles/develop
                ../profiles/graphical
            ];

            nixpkgs.overlays = config.nixpkgs.overlays;
        };
    };

    users.users.alex = {
        uid = 1000;
        isNormalUser = true;

        description = "Alex Zero";
        extraGroups = [ "wheel" "networkmanager" ];

        hashedPassword = lib.fileContents ../../secrets/passwords/alex.txt;
        openssh.authorizedKeys.keyFiles = [ ./sshkey.txt ];
    };
}
