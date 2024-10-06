{ pkgs, settings, ... }: {
  stylix = {
    enable = true;
    image = settings.wallpaper;

    polarity = "dark";

    opacity = {
      desktop = 0.0;
      terminal = 0.85;
      applications = 0.85;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 20;
    };
  };
}
