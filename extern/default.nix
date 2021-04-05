{ inputs, ... }:
with inputs;
{
    modules = [
        inputs.sops-nix.nixosModules.sops
    ];
}