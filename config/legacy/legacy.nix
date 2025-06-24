{
  inputs,
  pkgs,
  ...
}@args:

let
  imported = import ./default.nix args args;
  gepPlugin = pkgs.vimUtils.buildVimPlugin {
    name = "gep";
    src = ./.;
    doCheck = false;
  };
in
{
  extraPlugins = imported.hm-gep.programs.neovim.plugins ++ [ gepPlugin ];
  extraConfigLua = "require 'gep'";
  package = inputs.neovim-nightly.packages.${pkgs.system}.default;
}
