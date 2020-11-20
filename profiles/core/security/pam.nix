{ config, lib, pkgs, ... }:
{
    security.pam.u2f = {
        enable = true;
        control = "sufficient";
    };
}