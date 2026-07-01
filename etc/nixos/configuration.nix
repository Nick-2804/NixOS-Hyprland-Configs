# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:
  
 let
	spicePkgs = 
	inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
   in
{
  imports =
    [ 
      ./hardware-configuration.nix
	inputs.spicetify-nix.nixosModules.spicetify 
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 2;


  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  security.rtkit.enable = true;
  services.pipewire = {
 	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
};


  services.clamav = {
  daemon.enable = true;
  updater.enable = true;
};

  # Enable networking
  networking.networkmanager.enable = true;

  security.polkit.enable = true;

  services.xserver.enable = false;

  services.displayManager.enable = false;
  
  services.libinput.enable = true;

services.tlp.enable = true;
services.upower.enable = true;
services.thermald.enable = true;

services.tlp.settings = {
  CPU_BOOST_ON_BAT = 0;
  CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  PLATFORM_PROFILE_ON_BAT = "low-power";

  WIFI_PWR_ON_BAT = "on";
  USB_AUTOSUSPEND = 1;
  RUNTIME_PM_ON_BAT = "auto";
  SOUND_POWER_SAVE_ON_BAT = 1;
  PCIE_ASPM_ON_BAT = "powersupersave";
};

  nix.settings.experimental-features = [
    "nix-command" "flakes"
  ];

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."nick" = {
    isNormalUser = true;
    description = "Nick";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

   programs.spicetify = {
     enable = true;
     enabledExtensions = with spicePkgs.extensions; [
       adblockify
       shuffle # shuffle+ (special characters are sanitized out of extension names)
     ];
     #theme = spicePkgs.themes.catpuccin;
     #colorScheme = "mocha";
   };  

  programs.hyprland.enable = true;
  programs.steam.enable = true;
  programs.gamemode.enable = true;  
  programs.fish.enable = true;
    
  hardware.graphics = {
	enable = true;
	enable32Bit = true;
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    	  vlc
    	  discord
          neovim
    	  playerctl
	  vscode
	  fastfetch
	  btop
  	  cava
	  kitty
	  starship
	  walker
	  elephant
	  yazi
	  dunst
	  libnotify
   	  waybar
   	  awww
	  hyprpicker
	  hyprpolkitagent
	  hyprcursor
	  bibata-cursors
   	  git
	  lua5_4
	  ntfs3g
	  unzip
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  environment.shellAliases = {
  shypr	       = "start-hyprland";
  nixflake     = "sudo nvim /etc/nixos/flake.nix";
  nixconfig    = "sudo nvim /etc/nixos/configuration.nix";
  reboot       = "sudo reboot now";
  shutdown     = "sudo shutdown now";
  rebuild      = "sudo nixos-rebuild switch --flake /etc/nixos";
  upgrade      = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch --flake /etc/nixos";
};
  
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  fonts.packages = with pkgs; [
	  nerd-fonts.jetbrains-mono
  ];

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
  system.stateVersion = "26.05"; # Did you read the comment?

}


