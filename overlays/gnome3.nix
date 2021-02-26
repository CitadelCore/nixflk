final: prev: {
    gnome3 = prev.gnome3.overrideScope' (finalx: prevx: {
        gnome-session = prevx.gnome-session.overrideAttrs (o: {
            patches = [ ../pkgs/desktops/gnome-3/core/gnome-session/0001-fix-dbus-service.patch ];
        });

        gnome-settings-daemon = prevx.gnome-settings-daemon.overrideAttrs (o: {
            patches = [ ../pkgs/desktops/gnome-3/core/gnome-settings-daemon/0001-increase-ambient-hz.patch ];
        });
    });
}