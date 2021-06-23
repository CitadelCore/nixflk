{ pkgs, ... }:
{
    imports = [
        ./firefox

        # disable, this makes us build chromium from source
        # which takes fucking FOREVER
        # ./chromium
    ];
}