{
    home-manager = {
        users.alex = {
            imports = [
                ../profiles/core
                ../profiles/graphical
            ];

            programs.home-manager.enable = true;
            programs.bash.enable = true;
            
            home.stateVersion = "20.09";
        };
    };

    users.users.alex = {
        uid = 1000;
        isNormalUser = true;
        description = "Alex Zero";
        extraGroups = [ "wheel" "networkmanager" ];
        openssh.authorizedKeys.keyFiles = [ ./sshkey.txt ];
    };
}
