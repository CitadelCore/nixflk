{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.services.barrier;
    configFile = pkgs.writeText "barrier.sgc" cfg.config;
in
{
    options.services.barrier = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        config = mkOption {
            type = types.lines;
        };
    };

    config = mkIf cfg.enable {
        systemd.user.services.barrier = {
            Unit = {
                After = [ "graphical-session-pre.target" ];
                PartOf = [ "graphical-session.target" ];
            };

            Service = {
                ExecStart = "${pkgs.barrier}/bin/barriers --no-daemon --debug INFO --name thinkpad-alex --enable-crypto --address :24800 --config ${configFile}";
                ExecStop = "${pkgs.procps}/bin/pkill barriers";
                Restart = "always";
            };
        };
    };
}