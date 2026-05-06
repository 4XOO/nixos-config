



# Edit this configuration file to define what should be installed on your system.  Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by 
# running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
 
 # Enable OpenGL/Vulkan support
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Required for 32-bit applications (e.g., Steam)
  };

  # Load the amdgpu driver for X11/Wayland
  services.xserver.videoDrivers = [ "amdgpu" ];

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  # Konfiguration für das v4l2loopback Modul
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="Virtual Camera" exclusive_caps=1
  '';

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.firewall.allowedTCPPorts = [ 4747 ];
  networking.firewall.allowedUDPPorts = [ 4747 ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Niri Compositor aktivieren
  programs.niri.enable = true;

  # Empfohlene Ergänzung für Wayland-Compositoren
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };

  #Flatpak enable
  services.flatpak.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  #bluetooth
  hardware.bluetooth.enable = true;

  #services power
  services.power-profiles-daemon.enable = true;

  #services enable
  services.upower.enable = true;

  #flaks enable
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.david = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	inputs.noctalia.packages.${pkgs.system}.default
	git
	kitty
	xwayland
	waybar
	steam
	vesktop
	btop
	fish
	openrgb
	nh
	fuzzel
	fastfetch
	xwayland-satellite
	hyfetch
	linux-wallpaperengine
	droidcam
	lutris
	tailscale
	unrar
	heroic
	protonplus
	yazi
	asciiquarium
	prismlauncher

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  #wen ever openlap comes up in os switch turns doCheck into fals
  nixpkgs.config.packageOverrides = pkgs: {
    openldap = pkgs.openldap.overrideAttrs (oldAttrs: {
      doCheck = false;
      doInstallCheck = false;
    });
  };

  #GameScope  
  programs.gamescope = {
    enable = true;
    capSysNice = true;
};

#makeing Fastfetch auto use wen opening fish
programs.fish.interactiveShellInit = ''
  fastfetch
'';

  #OpenRgb Enable
  services.hardware.openrgb.enable = true;

  #tailscale Enable
  services.tailscale.enable = true;

  # Steam Enable
  programs.steam.enable = true;

  # Enable Fish Shell
  programs.fish.enable = true;


  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  #so nh knows were my configs are at
  programs.nh = {
    enable = true;
    flake = "/home/david/nixos-config"; # Dein Pfad
};

  #spicetify
  programs.spicetify = {
    enable = true;
    
    # Das hier ist die magische Zeile gegen die blaue Leiste:
    spotifyLaunchFlags = "--enable-features=UseOzonePlatform --ozone-platform=wayland";

    # Wähle ein Theme und Farbschema (optional, aber schick)
#    theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.comfy;
#    colorScheme = "rose-pine"; 

    # Nützliche Erweiterungen
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      adblock
      hidePodcasts
      shuffle # Besserer Shuffle-Algorithmus
    ];
  };



  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    users.david = import ./home.nix; # Hier wird die separate Datei geladen
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/619ede5c-6fa4-4b9b-bc1c-9a65720f652c";
    fsType = "ext4";
    options = [ "nofail" "user" "rw" "exec" ];
  };



}
