{
    imports = [ ./boot ];

    # enable wireshark for network debugging
    programs.wireshark.enable = true;

    # make pingable
    networking.firewall.allowPing = true;
}