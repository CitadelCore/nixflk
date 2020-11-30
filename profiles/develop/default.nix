{ pkgs, ... }:
{
    programs = {
        mtr.enable = true;
        traceroute.enable = true;
    };
}