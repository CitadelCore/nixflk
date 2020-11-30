{ lib, ... }:
{
    # nuke the temporary root volume on boot
    boot.initrd.postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/local/root@blank
    ''; # touch /etc/NIXOS

    # link the config in the persistent volume to the temporary volume
    system.activationScripts.linkNixos = {
        text = ''
            rm -rf /etc/nixos
            ln -s /persist/nixos /etc/nixos
        '';

        deps = [];
    };
}