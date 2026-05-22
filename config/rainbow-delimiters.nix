{
  ...
}:

{
  plugins.rainbow-delimiters = {
    enable = true;
    settings = {
      highlight = [
        "RainbowDelimiterYellow"
        "RainbowDelimiterPurple"
        "RainbowDelimiterBlue"
      ];
    };
  };

  highlight = {
    RainbowDelimiterYellow.fg = "#FAD430";
    RainbowDelimiterPurple.fg = "#C792ea";
    RainbowDelimiterBlue.fg = "#64B5F6";
  };
}
