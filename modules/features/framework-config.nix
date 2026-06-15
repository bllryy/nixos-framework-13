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
    #allowUnfree = true;
    nixpkgs.config.allowUnfree = true;

    users.users.lily = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" ];
      shell = pkgs.zsh;
    };
    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
      git vim wget curl
      firefox kitty
      brightnessctl playerctl alacritty vesktop
      tree go signal-desktop pavucontrol btop claude-code nodejs
    ];

    programs.steam.enable = true;
    
    services.flatpak.enable = true;  

    system.stateVersion = "26.05";
  };
}
