{ pkgs, ... }:
{
    home = {
        packages = with pkgs; [ rustup ];
        sessionPath = [ "\${HOME}/.cargo/bin" ];
    };
}