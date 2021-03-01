{ pkgs, ... }:
{
    boot = {
        tmpOnTmpfs = true;
        cleanTmpDir = true;

        loader.systemd-boot = {
            enable = true;
            configurationLimit = 10;
        };

        plymouth = {
            enable = false;
            logo = ./logo.png;
        };
    };
}
