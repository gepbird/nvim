{
  pkgs,
  ...
}:

let
  package = pkgs.vimPlugins.fzf-lua.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      (pkgs.fetchpatch {
        name = "fix-live-grep-delay-and-bugs.diff";
        url = "https://github.com/ibhagwan/fzf-lua/commit/5403b36b2a50495d472596d8f9fbe57554ecc84b.diff";
        hash = "sha256-uU6xb4nWisTvihBdoGKZK+yAKiVy9thGWVSdXquc2zg=";
      })
    ];
  });
in
{
  plugins.fzf-lua = {
    enable = true;
    inherit package;
    keymaps = {
      "<space><tab>" = "oldfiles";
      "<space>o" = "files";
      "<space>tg" = "live_grep";
      "<space>t<s-g>" = "grep";
      "<space>tb" = "buffers";
      "<space>tm" = "keymaps";
      "<space>th" = "helptags";
      "<space>tr" = "registers";
      "<space>tc" = "resume";
      "<space>gf" = "git_diff";
      "<space>gb" = "git_bcommits";
      "<space>gl" = "git_commits";
      "<space>ga" = "git_branches";
      "<space>tf" = "builtin";
      "<c-r>" = "command_history";
      "<space>," = "diagnostics_workspace";
    };
    settings = {
      winopts = {
        fullscreen = true;
      };
      keymap = {
        fzf = {
          "ctrl-d" = "half-page-down";
          "ctrl-u" = "half-page-up";
          "ctrl-h" = "first";
          "ctrl-l" = "last";
          "ctrl-a" = "toggle-all";
        };
      };
    };
  };
}
