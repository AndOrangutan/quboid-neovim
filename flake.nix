{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    neovim-nightly-overlay,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [neovim-nightly-overlay.overlays.default];
    };

    deps = with pkgs; [
      curl
      fzf
      git
      ripgrep
    ];

    full-deps = deps;
    bind-path = pkgs.lib.makeBinPath full-deps;
  in {
    packages."${system}".default = pkgs.wrapNeovim pkgs.neovim {
      configure = {
        customRC = ''
          set runtimepath^=${./.}
          luafile ${./init.lua}
        '';
      };

      extraMakeWrapperArgs = "--prefix PATH : ${bind-path}";
    };
  };
}
