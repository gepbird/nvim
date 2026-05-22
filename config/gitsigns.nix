{
  utils,
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

  keymaps = [
    {
      mode = "n";
      key = "<space>gj";
      action = utils.luaFunction "require('gitsigns').nav_hunk('next')";
    }
    {
      mode = "n";
      key = "<space>gk";
      action = utils.luaFunction "require('gitsigns').nav_hunk('prev')";
    }
    {
      mode = "n";
      key = "<space>gs";
      action = utils.luaFunction "require('gitsigns').stage_hunk()";
    }
    {
      mode = "x";
      key = "<space>gs";
      action = utils.luaFunction "require('gitsigns').stage_hunk({ vim.fn.line '.', vim.fn.line 'v' })";
    }
    {
      mode = "n";
      key = "<space>g<s-s>";
      action = utils.luaFunction "require('gitsigns').stage_buffer()";
    }
    {
      mode = "n";
      key = "<space>gr";
      action = utils.luaFunction "require('gitsigns').reset_hunk()";
    }
    {
      mode = "x";
      key = "<space>gr";
      action = utils.luaFunction "require('gitsigns').reset_hunk({ vim.fn.line '.', vim.fn.line 'v' })";
    }
    {
      mode = "n";
      key = "<space>g<s-r>";
      action = utils.luaFunction "require('gitsigns').reset_buffer()";
    }
    {
      mode = "n";
      key = "<space>gp";
      action = utils.luaFunction "require('gitsigns').preview_hunk_inline()";
    }
    {
      mode = "n";
      key = "<space>g<s-p>";
      action = utils.luaFunction "require('gitsigns').preview_hunk()";
    }
    {
      mode = [
        "o"
        "x"
      ];
      key = "ih";
      action = utils.luaFunction "require('gitsigns').select_hunk()";
    }
    {
      mode = [
        "o"
        "x"
      ];
      key = "ah";
      action = utils.luaFunction "require('gitsigns').select_hunk()";
    }
    {
      mode = "n";
      key = "<space><space>gb";
      action = utils.luaFunction "require('gitsigns').blame_line({ full = true })";
    }
    {
      mode = "n";
      key = "<space>g<s-b>";
      action = utils.luaFunction "require('gitsigns').blame()";
    }
    {
      mode = "n";
      key = "<space>gd";
      action = utils.luaFunction "require('gitsigns').diffthis()";
    }
  ];
}
