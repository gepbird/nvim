{
  plugins.undotree = {
    enable = true;
    settings = {
      WindowLayout = 2;
      SetFocusWhenToggle = true;
      ShortIndicators = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<space>u";
      action = ":UndotreeToggle<cr>";
    }
  ];
}
