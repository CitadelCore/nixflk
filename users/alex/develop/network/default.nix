{ pkgs, ... }:
{
    home.packages = with pkgs; [
        nmap whois atftp
    ];
}