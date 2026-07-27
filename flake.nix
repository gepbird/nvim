# reinstall command:
# `nix profile remove $(nix profile list --json | jq '.elements.nvim.storePaths[0]' --raw-output); nix profile install`
{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";
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
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import systems;

      imports = [
        nixvim.flakeModules.default
      ];

      nixvim = {
        packages.enable = true;
        checks.enable = true;
      };

      perSystem =
        {
          pkgs,
          self',
          system,
          ...
        }:
        {
          _module.args =
            let
              nixpkgs-patched = nixpkgs-patcher.lib.patchNixpkgs { inherit inputs system; };
            in
            import nixpkgs-patched {
              inherit system;
              config.allowUnfreePackages = [
                "omnisharp-extended-lsp.nvim" # no license upstream, 99% free
                "vim-sandwich" # no license upstream, 99% free
              ];
            };

          nixvimConfigurations = {
            default = nixvim.lib.evalNixvim {
              inherit system;
              modules = [
                self.nixvimModules.default
                { nixpkgs.pkgs = nixpkgs.lib.mkDefault pkgs; }
              ];
              extraSpecialArgs = inputs;
            };
            dev = self'.nixvimConfigurations.default.extendModules {
              modules = [
                {
                  enableMan = false;
                  enablePrintInit = false;
                }
              ];
            };
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              inotify-tools
            ];
          };
        };

      flake = {
        inherit inputs;

        nixvimModules.default = import-tree ./config;

        overlays.default = final: prev: {
          nvim-gep =
            (self.nixvimConfigurations.${prev.stdenv.system}.default.extendModules {
              modules = [ { nixpkgs.pkgs = prev; } ];
            }).config.build.package;
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
