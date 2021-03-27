{ pkgs, ... }:
{
    home.packages = with pkgs; [
        # Office
        xournalpp
        libreoffice-fresh

        # Sound
        audacity
        sonic-visualiser
        
        # 2D design
        krita
        inkscape
        gimp-with-plugins
        
        # 3D design
        #blender # Currently broken

        # Video capture
        obs-studio
        obs-v4l2sink
    ];
}