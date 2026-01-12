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
          lua << EOF
            local dev_path = os.getenv("NVIM_DEV_PATH")
            local rtp_path = dev_path or "${./.}"
            vim.opt.rtp:prepend(rtp_path)
            vim.opt.rtp:append(rtp_path .. "/after")
            dofile(rtp_path .. "/init.lua")
          EOF
        '';
      };

      extraMakeWrapperArgs = "--prefix PATH : ${bind-path}";
    };

    devShells."${system}".default = pkgs.mkShell {
      shellHook = ''
        export NVIM_DEV_PATH=$(pwd)
        echo "Neovim Dev Mode Enabled: Using $(pwd) for config"
      '';
    };
  };
}
