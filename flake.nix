{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [
        ./modules/features/common.nix
        ./modules/features/niri.nix
        ./modules/features/framework.nix
        ./modules/features/desktop.nix
        ./modules/features/configurations.nix
        ./modules/features/packages.nix
        ./modules/features/emacs.nix
      ];
    };
}
