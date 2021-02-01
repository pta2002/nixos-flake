{ pkgs, ... }:
let
  iosevka-term = pkgs.iosevka.override (attrs: {
    set = "term";

    privateBuildPlan = {
      family = "Iosevka Term";
      design = [
        "term" "v-l-italic" "v-i-italic" "v-g-singlestorey"
      ];
    };
  });
in
{
  fonts.fontconfig.enable = true;

  programs.kitty = {
    enable = true;
    font.package = iosevka-term;
    font.name = "Iosevka Term Extended";

    settings = rec {
      font_size = "16.0";

      bold_font = "Iosevka Term Bold Extended";
      italic_font = "Iosevka Term Italic Extended";
      bold_italic_font = "Iosevka Term Bold Italic Extended";

      symbol_map = "U+E0A0 Hack Nerd Font";

      disable_ligatures = "always";
      background_opacity = "0.5";
      window_padding_width = "5";

      foreground = color15;
      background = color0;

      color0 = "#282828";
      color1 = "#cc241d";
      color2 = "#98971a";
      color3 = "#d79921";
      color4 = "#458588";
      color5 = "#b16286";
      color6 = "#689d6a";
      color8 = "#928374";
      color7 = "#a89984";
      color9 = "#fb4934";
      color10 = "#b8bb26";
      color11 = "#fabd2f";
      color12 = "#83a598";
      color13 = "#d3869b";
      color14 = "#8ec07c";
      color15 = "#ebdbb2";
    };
  };
}
