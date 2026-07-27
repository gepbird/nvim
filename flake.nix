# reinstall command:
# `nix profile remove $(nix profile list --json | jq '.elements.nvim.storePaths[0]' --raw-output); nix profile install`
{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";
    nixpkgs-patch-stylelint-lsp-fix-build = {
      url = "https://github.com/NixOS/nixpkgs/pull/530554.diff";
      flake = false;
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    import-tree.url = "github:denful/import-tree";
    systems = {
      url = "github:nix-systems/default-linux";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    with inputs;
    let
      supportedSystems = import systems;
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f (forSystem system));
      forSystem = system: rec {
        nixpkgs-patched = nixpkgs-patcher.lib.patchNixpkgs { inherit inputs system; };
        pkgs = import nixpkgs-patched {
          inherit system;
          config.allowUnfreePackages = [
            "omnisharp-extended-lsp.nvim" # no license upstream, 99% free
            "vim-sandwich" # no license upstream, 99% free
          ];
        };
        nixvimLib = nixvim.lib.${system};
        nixvimPkgs = nixvim.legacyPackages.${system};
        nixvimModule = {
          module = import-tree ./config;
          extraSpecialArgs = inputs;
        };
        nvimWithOwnPkgs =
          pkgs:
          (nixvimPkgs.makeNixvimWithModule nixvimModule).extend {
            nixpkgs.pkgs = pkgs;
          };
        nvim = nvimWithOwnPkgs pkgs;
        devNvim = nvim.extend {
          enableMan = false;
          enablePrintInit = false;
        };
      };
    in
  flake-parts.lib.mkFlake { inherit inputs; } {
    systems = import systems;

    perSystem =
      { pkgs, system, ... }:
      let
        nixpkgs-patched = nixpkgs-patcher.lib.patchNixpkgs { inherit inputs system; };
        nixvimLib = nixvim.lib.${system};
        nixvimPkgs = nixvim.legacyPackages.${system};
        nixvimModule = {
          module = import-tree ./config;
          extraSpecialArgs = inputs;
          inherit pkgs;
        };
      in
      {
        _module.args = import nixpkgs-patched {
          inherit system;
          config.allowUnfreePackages = [
            "omnisharp-extended-lsp.nvim" # no license upstream, 99% free
            "vim-sandwich" # no license upstream, 99% free
          ];
        };

        legacyPackages.nvimWithOwnPkgs =
          pkgs: nixvimPkgs.makeNixvimWithModule (nixvimModule // { inherit pkgs; });

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            inotify-tools
          ];
        };

        checks.default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
      };

    flake = {
      inherit inputs;

      packages = forAllSystems (
        { nvim, devNvim, ... }:
        {
          default = nvim;
          dev = devNvim;
        }
      );

      overlays.default = final: prev: {
        nvim-gep = self.legacyPackages.${prev.stdenv.system}.nvimWithOwnPkgs prev;
      };
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
