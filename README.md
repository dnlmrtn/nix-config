# NixOS Configuration README

This README provides an overview of the configuration used for setting up the NixOS system. It includes essential configurations for booting, networking, system packages, user management, services, and more. The system is tailored for a user named `daniel`, and includes a variety of tools and software tailored to their development environment.

## Key Features

### Bootloader
- **Bootloader:** Systemd-boot is used as the bootloader for the system.
- **EFI Settings:** EFI variables are set to allow booting from an EFI system partition.

### Installed Packages
Current setup is:
- **Editor:** `neovim` 
- **Terminal:** `kitty`
- **Window Manager:** `i3`, 
- **Development:** `nodejs`, `poetry`, `git`, `wget`, `docker`, `docker-compose`, `tmux`
- **Other Tools:** `google-chrome` `slack`, `spotify`, `usbutils`, `alsa-utils`, `pavucontrol`

### Font Packages
- Custom fonts such as **FiraCode** and **DroidSansMono** are included via NerdFonts.

---

This configuration is flexible and can be adapted to different setups by modifying the relevant options. It’s recommended to review and adjust the configurations to suit specific hardware and use case needs.

