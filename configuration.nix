# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/efi";


	networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# ENV Variables

		environment.variables = {
			EDITOR = "nvim";
		};
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

# GPU Drivers
	hardware.opengl = {
		enable = true;
	};

	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia = {
# Modesetting required
		modesetting.enable = true;

		powerManagement.enable = false;


		powerManagement.finegrained = false;

# Use the NVIDIA open source kernel module
		open = false;

# Enable Nvidia settings menu
		nvidiaSettings = true;

		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
# Configure i3
	services.xserver = {
		enable = true;
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu #
        i3status # gives you the default i3 status bar
			];
		};
	};


# Audio drivers
	hardware.pulseaudio.enable = true;
	hardware.pulseaudio.support32Bit = true;
	nixpkgs.config.pulseaudio = true;

# Enable networking
	networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "America/Toronto";

# Select internationalisation properties.
	i18n.defaultLocale = "en_CA.UTF-8";

# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.daniel = {
		isNormalUser = true;
		description = "Daniel";
		extraGroups = [ "networkmanager" "wheel" "audio" "docker"];
		packages = with pkgs; [];
	};

# Enable automatic login for the user.
	services.getty.autologinUser = "daniel";

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;


	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
	];

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
		usbutils
			alsaUtils 
			pavucontrol
			lsof
			git 			
			gh
      i3
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
			slack			# Salk
			google-chrome		# Browser
			spotify			# Music
      docker-compose		# Containers
			];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.

	programs.neovim = {
		enable = true;
		vimAlias = true;
	};
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };
	virtualisation.docker.rootless = {
		enable = true;
		setSocketVariable = true;
	};

# Enable the OpenSSH daemon.
	services.openssh.enable = true;

# Open ports in the firewall.
networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 80 443 ];
  allowedUDPPortRanges = [
    { from = 4000; to = 4007; }
    { from = 8000; to = 8010; }
  ];
};

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.05"; # Did you read the comment?

}
