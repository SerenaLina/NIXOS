# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #<home-manager/nixos>
    ];

  # Bootloader.
 # boot.loader.systemd-boot.enable = true;
   boot.loader.grub.enable = true;
   boot.loader.grub.efiSupport = true;
   boot.loader.grub.device = "nodev";
   boot.loader.efi.canTouchEfiVariables = true;
   boot.loader.grub.extraEntries = ''
	menuentry "Windows11"{
		insmod part_gpt
		insmod fat
		search --file --no-floppy --set=root /EFI/Microsoft/Boot_backup/bootmgfw.efi
		chainloader /EFI/Microsoft/Boot_backup/bootmgfw.efi
		}
	'';

  networking.hostName = "nixos"; # Define your hostname.
  hardware.graphics = {
	enable = true;
};

  #services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
	modesetting.enable = true;
	powerManagement.enable = false;
	powerManagement.finegrained = false;
	open = false;

	nvidiaSettings = true;

	package = config.boot.kernelPackages.nvidiaPackages.stable;
};
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lina = {
    isNormalUser = true;
    description = "lina";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     terminus_font
     wqy_zenhei
     kbd
     file
     git
     libsForQt5.qt5.qtwayland
     kdePackages.qtwayland
     hyprland
     pyprland
     #xwayland
     #hyprpicker
     #hyprcursor
     #hyprlock
     #hypridle
     #hyprpaper
     #waypaper
     #hyprshot
     #kitty
     waybar
     google-chrome
     #wofi
     tofi
     #wlogout
     #dunst
     #hyprshade
     foot
     simple-mtpfs
     libmtp
     mtpfs
     gvfs
     fish
     fcitx5
     fcitx5-gtk
     fcitx5-configtool
     fontconfig
     mako
     alacritty
     swaybg

     pavucontrol
     pamixer
     pipewire
     wireplumber

     #thunar
     gvfs
     patchelf
     proxychains-ng
    # wechat-uos


     #font
     noto-fonts
     noto-fonts-cjk-sans
     inter-nerdfont
     noto-fonts-color-emoji
     sarasa-gothic
     gcc
     binutils
     appimage-run
     wechat-uos
     zsh
     neovim
     brightnessctl
     evtest
     pulseaudioFull
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
  system.stateVersion = "25.05"; # Did you read the comment?
  console = {
	font = "lat9w-16";
	useXkbConfig = true;
};
  nix.settings.experimental-features = 
	["nix-command" "flakes"];
  nix.settings.substituters = [
	"https://mirror.sjtu.edu.cn/nix-channels/store"
	"https://cache.nixos.org"
];

   i18n.inputMethod.enable = true;
   i18n.inputMethod.type = "fcitx5";
   i18n.inputMethod.fcitx5.addons = with pkgs; [
	fcitx5-gtk
        fcitx5-chinese-addons
        fcitx5-nord
];
  #services.xserver.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
   programs.hyprland.enable = true;
   environment.sessionVariables.NIXOS_OZONE_WL = "1";
   environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
   services.xserver.displayManager.gdm.enable = true;
   services.gvfs.enable = true;
   services.udisks2.enable = true;
   services.pipewire.enable = true;
   services.pipewire.wireplumber.enable = true;


   services.tlp.enable = true;
   services.tlp.settings = {
	CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
	CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
	PLATFORM_PROFILE_ON_BAT = "low-power";
	SCHED_POWERSAVE_ON_BAT = 1;
	USB_AUTOSUSPEND = 1;
	PCIE_ASPM_ON_BAT = "powersupersave";
};
   services.logind = {
	#enable = true;
	lidSwitch = "suspend";
	lidSwitchDocked = "ignore";
	lidSwitchExternalPower = "suspend";
	extraConfig = ''
		HandleSuspendKey=suspend
		HandleLidSwitch=suspend
		HandleLidSwitchExternalPower=suspend
		'';
	};

   programs.fish.enable = true;
   fonts.packages = with pkgs; [
	nerd-fonts.symbols-only
	inconsolata
];
    hardware.nvidia.prime = {
	intelBusId = "PCI:0:2:0";
	nvidiaBusId = "PCI:0:1:0";
};
    services.xserver.videoDrivers = [
	"modesetting"
	"nvidia"
];
    hardware.nvidia.prime = {
	offload = {
		enable = true;
		enableOffloadCmd = true;
	};
};
   # boot.kernelParams = ["nvidia-drm.modeset=1" ];
      

    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
	zlib glibc fontconfig freetype dbus xorg.libX11
	xorg.libXext xorg.libXrender libxkbcommon
	xorg.libxcb cairo gdk-pixbuf atk gtk3
	pango alsa-lib cups
	];

}

