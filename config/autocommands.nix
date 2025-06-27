{
  autoCmd = [
    {
      desc = "Highlight yanked text";
      event = "TextYankPost";
      callback = {
        __raw = ''
          function()
            vim.highlight.on_yank {
              higroup = "IncSearch",
              timeout = 700,
            }
          end
        '';
      };
    }
    {
      desc = "Don't start a comment when making a newline";
      event = "FileType";
      callback = {
        __raw = ''
          function()
            vim.opt.formatoptions:remove {
              'r',
              'o',
            }
          end
        '';
      };
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
      callback = {
        __raw = ''
          function()
            vim.bo.filetype = 'xml'
          end
        '';
      };
    }
  ];
}
