{
  utils,
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
      strategy."" = utils.lua ''
        function(bufnr)
          if utils.is_file_big(bufnr) then
            return nil
          end
          return require("rainbow-delimiters").strategy.global
        end
      '';
    };
  };

  highlight = {
    RainbowDelimiterYellow.fg = "#FAD430";
    RainbowDelimiterPurple.fg = "#C792ea";
    RainbowDelimiterBlue.fg = "#64B5F6";
  };
}
