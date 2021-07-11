{ my, ... }:
{
    programs.password-store = {
        enable = true;
        settings = {
            "PASSWORD_STORE_KEY" = my.pgp.fingerprint;
            "PASSWORD_STORE_CLIP_TIME" = "60";
        };
    };
}
