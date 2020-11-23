{ pkgs, ... }:
{
    programs = {
        mtr.enable = true;
        traceroute.enable = true;
    };

    environment.systemPackages = with pkgs; [
        nmap whois
    ];
}