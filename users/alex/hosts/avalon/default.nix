{ lib, pkgs, my, ... }: let
    inherit (lib.kuiser) systemGlobal;
    system = systemGlobal { inherit pkgs; };

    # HACK: copied from the NixOS repo
    inixCli = pkgs.writeShellScriptBin "inix" ''
        IFS=';' read -ra ARGS <<< $(${pkgs.inix-helper}/bin/inix-helper)
        nix "$@" "''\${ARGS[@]}" 
    '';
in {
    home = {
        packages = system.packages ++ (with pkgs; [
            inixCli nixUnstable
        ]);

        sessionVariables = system.variables;
    };

    programs = {
        bash.shellAliases = system.aliases;

        fish = {
            shellInit = ''
                fenv source "/home/${my.username}/.nix-profile/etc/profile.d/nix.sh";
            '';

            shellAliases = system.aliases;

            plugins = [{
                name = "plugin-foreign-env";
                src = pkgs.fetchFromGitHub {
                    owner = "oh-my-fish";
                    repo = "plugin-foreign-env";
                    rev = "dddd9213272a0ab848d474d0cbde12ad034e65bc";
                    sha256 = "00xqlyl3lffc5l0viin1nyp819wf81fncqyz87jx8ljjdhilmgbs";
                };
            }];
        };
    };
}
