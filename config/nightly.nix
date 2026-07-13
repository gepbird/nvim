{
  neovim-nightly,
  pkgs,
  ...
}:

{
  package = neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;
}
