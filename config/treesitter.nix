{
  lib,
  ...
}:

{
  plugins.treesitter = {
    enable = true;
    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
  };

  extraFiles."queries/nix/injections.scm".source = lib.mkForce ./treesitter-queries-nix.scm;
}
