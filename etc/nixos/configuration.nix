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

  # Alternative Bootloader for a Virtual Machine (disable the one above tho)
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/vda";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; 
  
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

  networking.networkmanager.enable = true;

  security.polkit.enable = true;

  services.xserver.enable = false;

  services.displayManager.enable = false;
  
  services.libinput.enable = true;

  # Use this instead when you are on a Desktop PC instead of the one below
  # services.power-profiles-daemon.enable = true;

  #For Laptops good because of the Batterylife
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

  time.timeZone = "Europe/Berlin";

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

  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Replace nick with your Username
  users.users."nick" = {
    isNormalUser = true;
    description = "Nick";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users.defaultUserShell = pkgs.fish;

  nixpkgs.config.allowUnfree = true;

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      shuffle 
    ];
  };  

  programs.hyprland.enable = true;
  programs.steam.enable = true;
  programs.gamemode.enable = true;  
  programs.fish.enable = true;
    
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    vlc
    discord
    neovim
    wl-clipboard
    playerctl
    brightnessctl
    vscode
    obsidian
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
    hyprshot
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

  system.stateVersion = "26.05"; # Did you read the comment?

}


