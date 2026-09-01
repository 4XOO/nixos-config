

{ config, pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;

  programs.home-manager.enable = true;

  programs.ghostty = {
    enable = true;

    settings = {
      background-opacity = "0.3";

      foreground = "#ffffff";
      background = "#4D3F1E";

      gtk-titlebar = false;

      cursor-style = "block";
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;

      theme = "Catppuccin Mocha";
    };
  };

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [ adblockify hidePodcasts shuffle ];

    theme = {
      name = "Liquify";
      src = inputs.liquify-theme;
      appendName = false;
    };
  };

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    git
    htop
  ];
}
