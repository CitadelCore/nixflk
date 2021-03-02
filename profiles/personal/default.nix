{
    imports = [ ./boot ];

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