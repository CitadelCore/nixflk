{ lib, ... }:
{
    i18n.defaultLocale = "en_GB.UTF-8";
    time.timeZone = "Europe/London";
    console.keyMap = lib.mkDefault "uk";
    location.provider = "geoclue2";
}
