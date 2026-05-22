{
  pkgs,
  utils,
  ...
}:

{
  plugins.treesitter = {
    enable = true;
    package = pkgs.vimPlugins.nvim-treesitter-legacy;
    settings = {
      highlight = {
        enable = true;
        disable = utils.lua ''
          function(_, bufnr)
            return utils.is_file_big(bufnr)
          end
        '';
        additional_vim_regex_highlighting = false;
      };
      indent = {
        enable = true;
        disable = utils.lua ''
          function(_, bufnr)
            return utils.is_file_big(bufnr)
          end
        '';
      };
    };
  };
}
