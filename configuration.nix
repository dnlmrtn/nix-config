{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

# --- BOOT --- 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

# --- ENV ---
  environment.variables = { EDITOR = "nvim"; };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# --- SERVICES ---
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    layout = "us";
    xkbVariant = "";
    displayManager.gdm = {
        enable = true;
        wayland = true;
    };
  };
  services.openssh.enable = true;

# --- HARDWARE ---
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting = {
        enable = true;
      };
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
      powerManagement = {
        enable = false;
      };
    };
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  }; 
  nixpkgs = {
    config = {
      pulseaudio = true;
      allowUnfree = true;
    };
  };

# --- USER  ---
  users.users.daniel = {
    isNormalUser = true;
    description = "Daniel";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    packages = with pkgs; [];
  };
  services.getty.autologinUser = "daniel";

# --- PACKAGES ---
  fonts.packages = with pkgs; [(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })];
  environment.systemPackages = with pkgs; 
  [
      usbutils
      alsaUtils 
      pavucontrol
      lsof
      git 			
      gh
      nodejs
      neovim		# Text editor
      tmux		# Terminal multiplexer
      xclip
      direnv
      kitty
      wayland
      wlroots
      sway
      wayland-utils
      wayland-protocols
      xwayland
      poetry
      dmenu			# Menu
      alacritty		# Terminal
      wget			
      hyprpaper		# Hyperpaper
      slack			# Slack
      google-chrome	# Browser
      spotify			# Music
      docker-compose	# Containers
  ];

  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
    };
    hyprland = {
      enable = true;
      xwayland = {
        enable = true;
      };
    };
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          });
    };
  };

# --- DOCKER ENABLE ---
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

# --- NETWORKING ---
  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; 
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPortRanges = [
    { from = 4000; to = 4007; }
    { from = 8000; to = 8010; }
    ];
  };

# --- MISC ---
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  system.stateVersion = "24.05";
}

