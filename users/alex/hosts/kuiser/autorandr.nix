{ pkgs, ... }:
{
    # make sure autorandr runs when i3 inits
    xsession.windowManager.i3.config.startup = [{
        command = "${pkgs.autorandr}/bin/autorandr -c";
        always = false;
    }];

    programs.autorandr = {
        enable = true;

        hooks.postswitch = {
            "notify-i3" = "${pkgs.i3}/bin/i3-msg restart";
        };

        profiles = {
            # laptop mode, only laptop display is active
            "default" = {
                fingerprint = {
                    "eDP-1" = "00ffffffffffff000dae3817000000002f1801049526157802a155a556519d280b505400000001010101010101010101010101010101b43b804a71383440302035007dd610000018000000fe004e3137334843452d4533310a20000000fe00434d4e0a202020202020202020000000fe004e3137334843452d4533310a200056";
                };

                config = {
                    "DP-0".enable = false;
                    "DP-1-0".enable = false;
                    "DP-1-0.1".enable = false;
                    "DP-1-0.2".enable = false;
                    "DP-1-0.3".enable = false;
                    "DP-1-1".enable = false;
                    "DP-1-2".enable = false;
                    "DP-1-3".enable = false;
                    "HDMI-1-0".enable = false;

                    # laptop
                    "eDP-1" = {
                        enable = true;
                        primary = true;

                        #crtc = 0;
                        position = "0x0";
                        mode = "1920x1080";
                        gamma = "1.471:1.0:0.714";
                        rate = "60.00";
                    };
                };
            };

            # docked mode, laptop display is disabled and monitors are active
            "docked" = {
                fingerprint = {
                    "eDP-1" = "00ffffffffffff000dae3817000000002f1801049526157802a155a556519d280b505400000001010101010101010101010101010101b43b804a71383440302035007dd610000018000000fe004e3137334843452d4533310a20000000fe00434d4e0a202020202020202020000000fe004e3137334843452d4533310a200056";
                    "DP-1-0.2" = "00ffffffffffff004c2d350f33385743331d0104b54627783baea5af4f42af260f5054bfef80714f810081c08180a9c0b3009500010122cc0050f0703e8018103500b9882100001a000000fd00283c86863c010a202020202020000000fc005533324a3539780a2020202020000000ff0048345a4d4330303239300a202001b702030ff042105f2309070783010000023a801871382d40582c4500b9882100001e565e00a0a0a0295030203500b9882100001a04740030f2705a80b0588a00b9882100001e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056";
                    "DP-1-0.3" = "00ffffffffffff004c2d350f33385743321d0104b54627783baea5af4f42af260f5054bfef80714f810081c08180a9c0b30095000101e2ca0038f0703e8018103500b9882100001a000000fd00283c86863c010a202020202020000000fc005533324a3539780a2020202020000000ff0048345a4d4330303231320a2020011802030ff042105f2309070783010000023a801871382d40582c4500b9882100001e565e00a0a0a0295030203500b9882100001a04740030f2705a80b0588a00b9882100001e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056";
                };

                config = {
                    #"eDP-1".enable = false; # laptop
                    "DP-0".enable = false;
                    "DP-1-0".enable = false;
                    "DP-1-0.1".enable = false;
                    "DP-1-1".enable = false;
                    "DP-1-2".enable = false;
                    "DP-1-3".enable = false;
                    "HDMI-1-0".enable = false;

                    # laptop
                    "eDP-1" = {
                        enable = true;
                        #primary = true;

                        #crtc = 0;
                        position = "0x2160";
                        mode = "1920x1080";
                        gamma = "1:1:1";
                        rate = "60.00";
                    };

                    # centre
                    "DP-1-0.2" = {
                        enable = true;
                        primary = true;

                        #crtc = 0;
                        position = "0x0";
                        mode = "3840x2160";
                        gamma = "1:1:1";
                        rate = "60.00";
                    };

                    # right
                    "DP-1-0.3" = {
                        enable = true;

                        #crtc = 2;
                        position = "3840x0";
                        mode = "3840x2160";
                        gamma = "1:1:1";
                        rate = "30.00"; # compromise :(
                        rotate = "right";
                    };
                };
            };
        };
    };
}