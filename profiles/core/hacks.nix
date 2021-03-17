{ lib, ... }:
{
    options.deployment.keys = with lib; mkOption {
        default = {};
        type = types.attrs;
    };
}