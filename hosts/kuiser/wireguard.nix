{ lib, name, ... }: let
    inherit (lib.arnix) mkHostSecretPath;
in {
    # Temporary hacky tunnel
    networking.interfaces.wg0.mtu = 1420;

    networking.wireguard = {
        enable = true;

        # This is the fallback link to Helios Stirling (stir1)
        # It is the backdoor to Arctarus infrastructure should any RIS components fail
        interfaces.wg0 = {
            listenPort = 51592;
            ips = [ "10.8.16.15/32" "2a10:4a80:7:16::15/64" ];
            privateKeyFile = "/persist/secrets/hosts/kuiser/wg-failsafe.txt";

            peers = [{
                endpoint = "81.145.136.67:51820";
                publicKey = "lna4F7/fJrC0DzOm6Dx3ggqx/smJ1/2faWQvLhr88Qs=";
                persistentKeepalive = 25; # we're mobile so almost certainly behind NAT

                allowedIPs = [
                    "10.60.10.0/24"
                    "208.64.203.133/32" # Valve's Perforce server
                    "2a10:4a80:7:8::1/128"
                    "2a10:4a80:7:8::10/128"
                    "2a10:4a80:7:8::30/128"
                ];
            }];
        };
    };
}