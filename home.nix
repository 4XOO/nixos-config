


{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;

    settings = {
      background_opacity = "0.4";
      confirm_os_window_close = 0;
    };

    extraConfig = ''
      foreground      #ffffff
      background      #b1b1b1
      cursor_shape    beam
      scrollback_lines 10000
    '';

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
  };

programs.ghostty = {
  enable = true;

  settings = {
    background-opacity = "0.4";

    foreground = "#ffffff";
    background = "#1a265a";

    cursor-style = "block";   # or "bar", "underline", "block_hollow"
    font-family = "JetBrainsMono Nerd Font";
    font-size = 12;
    
    theme = "Catppuccin Mocha";
  };
};
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    git
    htop
  ];

}


