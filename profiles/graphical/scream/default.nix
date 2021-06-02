{ config, lib, pkgs, ... }:
with lib;
let
    package = pkgs.scream.override {
        pulseSupport = true;
    };
in
{
    systemd.user.services.scream = {
        enable = true;

        environment = {
            "PULSE_SERVER" = "unix:/run/user/1000/pulse/native";
            "HOME" = "/home/alex";
        };

        serviceConfig = {
            ExecStart = "${package}/bin/scream -o pulse -u";
            ExecStop = "${pkgs.procps}/bin/pkill scream";
            Restart = "always";
        };

        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
    };

    networking.firewall.allowedUDPPorts = [ 4010 ];
}
