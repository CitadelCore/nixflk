{ role }: let
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
    inherit role;
    pgp.fingerprint = "A0AA4646B8F69D4545535A88A51550EDB450302C";
} // roles.${role}
