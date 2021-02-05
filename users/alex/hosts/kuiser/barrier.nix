{
    services.barrier = {
        enable = true;
        config = ''
            section: screens
                DESKTOP-T33DUIP:
                    halfDuplexCapsLock = false
                    halfDuplexNumLock = false
                    halfDuplexScrollLock = false
                    xtestIsXineramaUnaware = false
                    preserveFocus = false
                    switchCorners = none 
                    switchCornerSize = 0
                thinkpad-alex:
                    halfDuplexCapsLock = false
                    halfDuplexNumLock = false
                    halfDuplexScrollLock = false
                    xtestIsXineramaUnaware = false
                    preserveFocus = false
                    switchCorners = none 
                    switchCornerSize = 0
            end

            section: aliases
            end

            section: links
                DESKTOP-T33DUIP:
                    right = thinkpad-alex
                thinkpad-alex:
                    left = DESKTOP-T33DUIP
            end

            section: options
                relativeMouseMoves = true
                screenSaverSync = true
                win32KeepForeground = false
                clipboardSharing = true
                switchCorners = none 
                switchCornerSize = 0
                keystroke(Control+Shift+1) = lockCursorToScreen(toggle)
            end
        '';
    };
}