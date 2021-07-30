{
    # enable rabbitmq on localhost for various purposes
    services.rabbitmq.enable = true;

    # setcap wrappers and stuff
    programs = {
        adb.enable = true;
        wireshark.enable = true;
    };
}