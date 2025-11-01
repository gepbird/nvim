# reinstall command:
# `nix profile remove $(nix profile list --json | jq '.elements.nvim.storePaths[0]' --raw-output); nix profile install`
{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.nuschtosSearch.follows = "";
      inputs.systems.follows = "systems";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    # use newer main branch, see https://github.com/nvim-treesitter/nvim-treesitter-textobjects/pull/692
    nvim-treesitter-textobjects = {
      url = "github:nvim-treesitter/nvim-treesitter-textobjects/main";
      flake = false;
    };
    # dependencies of the above modules
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    systems = {
      url = "github:nix-systems/default";
    };
  };

  outputs =
    inputs:
    with inputs;
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f (forSystem system));
      forSystem = system: rec {
        pkgs = import nixpkgs { inherit system; };
        nixvimLib = nixvim.lib.${system};
        nixvimPkgs = nixvim.legacyPackages.${system};
        nixvimModule = {
          module = import ./config;
          extraSpecialArgs = inputs;
        };
        nvim = nixvimPkgs.makeNixvimWithModule nixvimModule;
        nvimWithOwnPkgs =
          pkgs:
          (nixvimPkgs.makeNixvimWithModule nixvimModule).extend {
            nixpkgs.pkgs = pkgs;
          };
        devNvim = (nixvimPkgs.makeNixvimWithModule nixvimModule).extend {
          enableMan = false;
          enablePrintInit = false;
        };
        devShell = pkgs.mkShell {
          packages = with pkgs; [
            inotify-tools
          ];
        };
      };
    in
    {
      checks = forAllSystems (
        { nixvimLib, nixvimModule, ... }:
        {
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
        }
      );

      packages = forAllSystems (
        { nvim, devNvim, ... }:
        {
          default = nvim;
          dev = devNvim;
        }
      );

      overlays.default = final: prev: {
        nvim-gep = (forSystem prev.system).nvimWithOwnPkgs prev;
      };

      devShells = forAllSystems (
        { devShell, ... }:
        {
          default = devShell;
        }
      );
    };
}
