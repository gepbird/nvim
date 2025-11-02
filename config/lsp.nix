{
  lsp = {
    servers = {
      jsonls.enable = true;
      lemminx.enable = true;
      taplo.enable = true;
      yamlls.enable = true;
    };
  };

  plugins.lsp = {
    enable = true;
    servers = {
      elixirls.enable = true;
    };
  };
}
