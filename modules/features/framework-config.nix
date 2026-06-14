{ self, inputs, ... }: {
  flake.nixosModules.frameworkConfig = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "framework";
    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    services.fwupd.enable = true;
    services.fprintd.enable = true;
    services.power-profiles-daemon.enable = true;

    users.users.lily = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" ];
      shell = pkgs.zsh;
    };
    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
      git vim wget curl
      firefox kitty
      brightnessctl playerctl
    ];

    system.stateVersion = "25.05";
  };
}
