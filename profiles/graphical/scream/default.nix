{ config, lib, pkgs, ... }:
with lib;
{
    systemd.user.services.scream = {
        enable = true;

        environment = {
            "PULSE_SERVER" = "unix:/run/user/1000/pulse/native";
            "HOME" = "/home/alex";
        };

        serviceConfig = {
            ExecStart = "${pkgs.scream-receivers}/bin/scream -u -o pulse -n \"Windows PC\"";
            ExecStop = "${pkgs.procps}/bin/pkill scream";
            Restart = "always";
        };

        wantedBy = [ "graphical.target" ];
    };

    networking.firewall.allowedUDPPorts = [ 4010 ];
}
