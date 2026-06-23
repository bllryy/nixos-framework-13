{ self, inputs, ... }: {
  flake.nixosModules.framework = { pkgs, lib, ... }: {
    networking.hostName = "framework";

    services.fwupd.enable = true;
    services.fprintd.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
