{
  utils,
  ...
}:

{
  autoCmd = [
    {
      desc = "Highlight yanked text";
      event = "TextYankPost";
      callback = utils.luaFunction ''
        vim.hl.hl_op {
          higroup = "IncSearch",
          timeout = 700,
        }
      '';
    }
    {
      desc = "Don't start a comment when making a newline";
      event = "FileType";
      callback = utils.luaFunction ''
        vim.opt.formatoptions:remove {
          'r',
          'o',
        }
      '';
    }
    {
      desc = "Treat XAML files as XML";
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [
        "*.xaml"
      ];
      callback = utils.luaFunction ''
        vim.bo.filetype = 'xml'
      '';
    }
  ];
}
