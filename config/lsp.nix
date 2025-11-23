{
  lsp = {
    servers = {
      cssls.enable = true;
      emmet_language_server.enable = true;
      html.enable = true;
      jsonls.enable = true;
      lemminx.enable = true;
      taplo.enable = true;
      yamlls.enable = true;
      tinymist = {
        enable = true;
        config.settings.formatterMode = "typstyle";
      };
      nil_ls = {
        enable = true;
        config.settings.nil = {
          nix.flake.autoArchive = true;
        };
      };
    };
  };

  plugins.lsp = {
    enable = true;
    servers = {
      elixirls.enable = true;
    };
  };
}
