{ self, inputs, ... }: {
  flake.nixosModules.common = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.niri
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";
    i18n.defaultLocale = "en_US.UTF-8";

    nixpkgs.config.allowUnfree = true;

    users.users.lily = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" ];
      shell = pkgs.zsh;
    };
    programs.zsh.enable = true;

    fonts.packages = with pkgs; [ nerd-fonts.iosevka ];

    environment.systemPackages = with pkgs; [
      git vim wget curl
      firefox kitty
      brightnessctl playerctl alacritty vesktop
      tree go signal-desktop pavucontrol btop claude-code nodejs cmake ungoogled-chromium tree prismlauncher 
      fastfetch keepassxc kdePackages.dolphin filezilla tmux fzf emacs pkg-config unzip vscode gcc
      libtool 
    ];

    programs.steam.enable = true;
    services.flatpak.enable = true;

    system.stateVersion = "26.05";
  };
}
