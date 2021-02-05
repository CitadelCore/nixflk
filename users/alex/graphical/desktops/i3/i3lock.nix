{ pkgs, ... }:
{
    services.screen-locker = {
        enable = true;
        lockCmd = "${pkgs.i3lock} -n -c 000000 -f";
    };
}