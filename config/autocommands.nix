{
  autoCmd = [
    {
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
      event = "FileType";
      callback = {
        __raw = ''
          function()
            vim.opt.formatoptions:remove {
              'c',
              'r',
              'o',
            }
          end
        '';
      };
    }
    {
      event = [
        "BufRead"
        "BufNewFile"
      ];
      pattern = [
        "*.xaml"
        "*.axaml"
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
