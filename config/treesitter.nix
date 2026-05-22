{
  pkgs,
  ...
}:

{
  plugins.treesitter = {
    enable = true;
    package = pkgs.vimPlugins.nvim-treesitter-legacy;
    settings = {
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = false;
      };
      indent = {
        enable = true;
      };
    };
  };
}
