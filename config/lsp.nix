{
  lsp = {
    servers = {
      jsonls.enable = true;
      lemminx.enable = true;
      taplo.enable = true;
      yamlls.enable = true;
      nil_ls.enable = true;
    };
  };

  plugins.lsp = {
    enable = true;
    servers = {
      elixirls.enable = true;
    };
  };
}
