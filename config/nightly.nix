{
  neovim-nightly,
  pkgs,
  lib,
  ...
}:

let
  fastBuild = false;
in
{
  package = neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (
    old:
    lib.optionalAttrs fastBuild {
      doCheck = false;
      doInstallCheck = false;
      cmakeFlags = old.cmakeFlags ++ [
        (lib.cmakeBool "ENABLE_LTO" false)
      ];
    }
  );
}
