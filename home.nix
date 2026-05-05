{ pkgs, ... }: { home.stateVersion = "25.11"; home.enableNixpkgsReleaseCheck = false; programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      background_opacity = "0.2";
      confirm_os_window_close = 0;
    };
    
    extraConfig = ''
      foreground      #dddddd
      background      #880808
      cursor_shape    beam
      scrollback_lines 10000
    '';

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    git
    htop
  ];
}
