{
    imports = [ ./boot ];

    services = {
        # for network discovery
        avahi = {
            enable = true;
            nssmdns = true;
        };
    };

    networking.networkmanager = {
        enable = true;

        # stable randomised MAC address that resets at boot
        # wifi.macAddress = "stable";
        # ethernet.macAddress = "stable";

        # extraConfig = ''
        #     [connection]
        #     connection.stable-id=''${CONNECTION}/''${BOOT}
        # '';
    };
}