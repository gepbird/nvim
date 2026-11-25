{ pkgs, ... }:
{
  lsp = {
    servers = {
      cssls.enable = true;
      tailwindcss.enable = true;
      emmet_language_server.enable = true;
      html.enable = true;
      jsonls.enable = true;
      lemminx.enable = true;
      taplo.enable = true;
      yamlls.enable = true;
      elixirls.enable = true;
      bashls.enable = true;
      stylelint_lsp.enable = true;
      terraformls.enable = true;
      tinymist = {
        enable = true;
        config.settings.formatterMode = "typstyle";
      };
      nil_ls = {
        enable = true;
        package = pkgs.lixPackageSet.nil or pkgs.lixPackageSets.lix_2_96.nil;
        config.settings.nil = {
          nix.flake.autoArchive = true;
        };
      };
    };
  };

  extraPackages = with pkgs; [
    shfmt
  ];
}
