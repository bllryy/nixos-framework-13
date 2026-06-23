{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.noctalia = pkgs.callPackage ../../pkgs/noctalia.nix {};
  };

  flake.nixosModules.packages = { pkgs, ... }: {
    environment.systemPackages = [
      (pkgs.callPackage ../../pkgs/noctalia.nix {})
    ];
  };
}
