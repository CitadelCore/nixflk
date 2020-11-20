{ config, lib, pkgs, ... }:
with lib;
let
    cfg = config.services.barrier;
in
{
    options.services.barrier = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };
    };

    config = mkIf cfg.enable {
        environment.systemPackages = [ pkgs.barrier ];
    };
}