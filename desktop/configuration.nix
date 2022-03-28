{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ];

  nix = {
    package = pkgs.nixUnstable; # or versioned attributes like nix_2_4
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
    };
  }; 

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = { enable = true; };
      efi = { canTouchEfiVariables = true; };
      grub = { useOSProber = true; };
    };
  };

  networking = {
    hostName = "gilberto";
    networkmanager = { enable = true; };
  };

  # Set your time zone.
  time = {
    timeZone = "America/Argentina/Buenos_Aires";
    hardwareClockInLocalTime = true;
  };

  # Select internationalisation properties.
  i18n = { defaultLocale = "en_US.UTF-8"; };

  console = {
    font = "lat9w-16";
    keyMap = "es";
  };

  # Enable the X11 windowing system.
  services = {
    openssh = { enable = false; };

    dnsmasq = { enable = false; };

    gnome = { 
      gnome-keyring = { enable = true; };
    };

    xserver = {
      enable = true;
      layout = "es";
      displayManager = {
        lightdm = { enable = true; };
        defaultSession = "none+i3";
        sessionCommands = '' 
          xset s off
          xset -dpms
          xset s noblank
          xset r rate 210 40
          setxkbmap es
        '';
      };

      windowManager = {
        i3 = {
          enable = true;
          extraPackages = with pkgs; [
              dmenu 
              i3status 
              i3lock 
              i3blocks 
          ];
          package = pkgs.i3-gaps;
        };

        bspwm = {
          enable = true;
        };
      };
    };
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      gilberto = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "vboxusers" "libvirtd" "qemu-libvirtd" ]; 
        initialPassword = "gilberto";
        shell = pkgs.zsh;
      };
    }; 
  };

  fonts = {
    fontDir = { enable = true; };
    fonts = with pkgs; [
      ttf_bitstream_vera
      cantarell-fonts
      liberation_ttf
      cascadia-code
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira-code
      fira-code-symbols
      fira-mono
      dina-font
      proggyfonts 
      inconsolata
      anonymousPro
      hack-font
      roboto
      (nerdfonts.override { 
        fonts = [ "FiraCode" "UbuntuMono" "JetBrainsMono" "Meslo" "RobotoMono" ]; 
      })
    ];
  };

  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
    libvirtd = {
      enable = true;
      onShutdown = "shutdown";
      onBoot = "start";
      allowedBridges = [ "virbr0" ];
      qemu = {
        package = pkgs.qemu_kvm;
      };
    };
    docker = {
      enable = true;
      enableOnBoot = false;
    };
  };

  environment = {
    sessionVariables = {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_BIN_HOME    = "$HOME/.local/bin";
    };
    
    etc."xdg/user-dirs.defaults".text = ''
      DESKTOP=Desktop
      DOWNLOAD=Downloads
      TEMPLATES=Templates
      PUBLICSHARE=Public
      DOCUMENTS=Documents
      MUSIC=Music
      PICTURES=Pictures
      VIDEOS=Videos
    '';

    variables = { 
      PATH = "$HOME/.bin:$PATH"; 
      EDITOR = "nvim";
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      vim
      wget
      psmisc
      pavucontrol
      lsof
      git
      kitty
      
      zip
      unzip
      p7zip
      unrar

      gnumake
      htop

      brave

      virt-manager
      OVMF
      vde2
      bridge-utils
      netcat

      sxhkd
    ];
  };

  system.stateVersion = "unstable"; 

}
