{
    imports = [
        ../../graphical/desktops/i3
        ../../graphical/gaming

        ./autorandr.nix
        ./barrier.nix
    ];

    xsession.windowManager.i3.extraConfig = ''
        workspace 1 output eDP-1
        workspace 2 output DP-1-0.2
        workspace 3 output DP-1-0.3
    '';
}
