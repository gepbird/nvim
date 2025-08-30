{
  pkgs,
  ...
}:

# TODO: upstream
{
  extraPlugins = [
    pkgs.vimPlugins.remember-nvim
  ];

  extraConfigLua = ''
    require("remember").setup {
    }
  '';
}
