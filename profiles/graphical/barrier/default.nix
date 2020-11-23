{ config, lib, pkgs, ... }:
with lib;
let
    configFile = pkgs.writeText "barrier.sgc" (fileContents ./barrier.sgc);
in
{
    systemd.user.services.barrier = {
        enable = true;

        serviceConfig = {
            ExecStart = "${pkgs.barrier}/bin/barriers --no-daemon --debug INFO --name thinkpad-alex --enable-crypto --address :24800 --config ${configFile}";
            ExecStop = "${pkgs.procps}/bin/pkill barriers";
            Restart = "always";
        };

        after = [ "graphical-session-pre.target" ];
        partOf = [ "graphical-session.target" ];
    };

    networking.firewall.allowedTCPPorts = [ 24800 ];
}
