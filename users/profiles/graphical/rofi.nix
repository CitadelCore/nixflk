{ pkgs, ... }:

let
    rofi-power-menu = with pkgs; stdenv.mkDerivation rec {
        pname = "rofi-power-menu";
        version = "3.0.1";
        src = fetchFromGitHub {
            owner = "jluttine";
            repo = pname;
            rev = version;
            sha256 = "1kab1wabm5h73rj5p3114frjb7f1iqli89kfddrhp8z0n8348jw9";
        };

        installPhase = ''
            install -Dm755 rofi-power-menu $out/bin/rofi-power-menu
            install -Dm755 dmenu-power-menu $out/bin/dmenu-power-menu
        '';
    };
in
{
    programs.rofi = {
        enable = true;
        package = pkgs.rofi.override {
            plugins = with pkgs; [
                rofi-calc
                rofi-emoji
                rofi-file-browser
            ];
        };
    };

    home.packages = [ rofi-power-menu ];
}