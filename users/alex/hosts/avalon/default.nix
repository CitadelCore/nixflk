{ lib, pkgs, ... }: let
    # HACK: copied from the NixOS repo
    inixCli = pkgs.writeShellScriptBin "inix" ''
        IFS=';' read -ra ARGS <<< $(${pkgs.inix-helper}/bin/inix-helper)
        nix "$@" "''\${ARGS[@]}" 
    '';
in {
    home.packages = [ inixCli ];
}
