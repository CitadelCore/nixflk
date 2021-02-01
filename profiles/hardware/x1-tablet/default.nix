{ pkgs, ... }:

let
    screenLockScript = pkgs.writeShellScript "screen-lock.sh" ''
        display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | tail -n 1)"
        user="$(who | grep '('$display')' | ${pkgs.gawk}/bin/awk '{print $1}' | head -n 1)"
        uid="$(id -u $user)"
        ${pkgs.sudo}/bin/sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus \
            ${pkgs.dbus}/bin/dbus-send --type=method_call --dest=org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock
    '';
in
{
    boot = {
        # we're hidpi so use lower res for boot
        loader.systemd-boot.consoleMode = "1";

        # use latest kernel version
        kernelPackages = pkgs.linuxPackages_5_10;
        kernelPatches = [
            # fix for the keyboard function keys
            {
                name = "tpx1-cover";
                patch = ./tpx1-cover.patch;
            }
        ];
    };

    #sound.extraConfig = ''
    #    options snd-hda-intel model=laptop-dmic
    #'';
    
    services.logind = {
        # properly sleep on lid close
        lidSwitchDocked = "suspend";

        # make sure we ignore buttons
        # as we're doing things our own way
        extraConfig = ''
            HandlePowerKey=ignore
            HandleSuspendKey=ignore
            HandleHibernateKey=ignore
            HandleRebootKey=ignore
        '';
    };

    services.acpid = {
        enable = true;
        powerEventCommands = ''
            ${screenLockScript}
        '';
    };

    # enable sensors
    hardware.sensor.iio.enable = true;

    # enable the fingerprint sensor
    services.fprintd.enable = true;
}