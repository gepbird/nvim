{
  lib,
  ...
}:

{
  plugins.gitsigns = {
    enable = true;
    settings = {
      signcolumn = false;
      numhl = true;
      attach_to_untracked = true;
    };
  };

  keymaps =
    let
      wrapLuaFunction = action: "function() ${action} end";
      gs = action: lib.nixvim.mkRaw (wrapLuaFunction "require('gitsigns').${action}");
    in
    [
      {
        mode = "n";
        key = "<space>gj";
        action = gs "nav_hunk 'next'";
      }
      {
        mode = "n";
        key = "<space>gk";
        action = gs "nav_hunk 'prev'";
      }
      {
        mode = "n";
        key = "<space>gs";
        action = gs "stage_hunk()";
      }
      {
        mode = "x";
        key = "<space>gs";
        action = gs "stage_hunk { vim.fn.line '.', vim.fn.line 'v' }";
      }
      {
        mode = "n";
        key = "<space>g<s-s>";
        action = gs "stage_buffer()";
      }
      {
        mode = "n";
        key = "<space>gr";
        action = gs "reset_hunk()";
      }
      {
        mode = "x";
        key = "<space>gr";
        action = gs "reset_hunk { vim.fn.line '.', vim.fn.line 'v' }";
      }
      {
        mode = "n";
        key = "<space>g<s-r>";
        action = gs "reset_buffer()";
      }
      {
        mode = "n";
        key = "<space>gp";
        action = gs "preview_hunk_inline()";
      }
      {
        mode = "n";
        key = "<space>g<s-p>";
        action = gs "preview_hunk()";
      }
      {
        mode = [
          "o"
          "x"
        ];
        key = "ih";
        action = gs "select_hunk()";
      }
      {
        mode = [
          "o"
          "x"
        ];
        key = "ah";
        action = gs "select_hunk()";
      }
      {
        mode = "n";
        key = "<space><space>gb";
        action = gs "blame_line { full = true }";
      }
      {
        mode = "n";
        key = "<space>g<s-b>";
        action = gs "blame()";
      }
      {
        mode = "n";
        key = "<space>gd";
        action = gs "diffthis()";
      }
    ];
}
