{ pkgs, ... }:
{
    home.packages = with pkgs; [
        nmap # Network scanning
        whois # DNS resolution
        atftp # TFTP client
        net-snmp # SNMP tools
    ];
}