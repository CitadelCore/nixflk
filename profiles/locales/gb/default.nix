{ lib, ... }:
{
    i18n.defaultLocale = "en_GB.UTF-8";
    time.timeZone = "Europe/London";
    location.provider = "geoclue2";

    console.keyMap = lib.mkDefault "uk";
    services.xserver.layout = lib.mkDefault "gb";
}
