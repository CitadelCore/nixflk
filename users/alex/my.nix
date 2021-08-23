{ host }: let
    # switch name depending on whether
    # this is a work machine or not (to avoid confusion)
    role = if host == "redshift" then "work" else "personal";
    
    # is this machine running under windows subsystem for linux?
    wsl = if host == "avalon" then true else false;

    # disable graphical for wsl
    graphical = if wsl then false else true;

    roles = {
        personal = {
            name = "Alex Zero";
            email = "joseph@marsden.space";
            username = "alex";
        };

        work = {
            name = "Joseph Marsden";
            email = "joseph.marsden@speech-graphics.com";
            username = "jmarsden";
        };
    };
in {
    inherit role wsl graphical;
    pgp.fingerprint = "A0AA4646B8F69D4545535A88A51550EDB450302C";
} // roles.${role}
