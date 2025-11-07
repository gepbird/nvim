{
  lsp = {
    servers = {
      jsonls.enable = true;
      lemminx.enable = true;
      taplo.enable = true;
      yamlls.enable = true;
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
