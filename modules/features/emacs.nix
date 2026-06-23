{ self, ... }: {
    flake.nixosModules.emacs = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.emacs ];

      system.userActivationScripts.emacsConfig = {
        text = ''
          target="$HOME/.config/emacs"
          if [ -L "$target" ] || [ ! -e "$target" ]; then
            ln -sfn /home/lily/projects/emacs-config "$target"
          fi
        '';
      };
   };
}
