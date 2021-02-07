{ lib, ... }:
{
    # reference: https://grahamc.com/blog/erase-your-darlings
    # nuke the temporary root volume on boot
    boot.initrd.postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/local/root@blank
    ''; # touch /etc/NIXOS

    # link the config in the persistent volume to the temporary volume
    system.activationScripts.linkPersist = {
        text = ''
            mkPersistDir()
            {
                mkdir -p "$1"
                rm -rf "$2"
                ln -sT "$1" "$2"
            }

            mkPersistDir /persist/nixos /etc/nixos
            mkPersistDir /persist/etc/NetworkManager/system-connections /etc/NetworkManager/system-connections
            mkPersistDir /persist/var/lib/bluetooth /var/lib/bluetooth

            # make sure /persist/nixos has correct perms
            chmod -R 600 /persist/nixos/secrets
        '';

        deps = [];
    };
}
