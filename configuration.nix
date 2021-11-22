{ config, pkgs, ... }:

{ imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "gilberto";
    networkmanager = {
      enable = true;
    };
  };

  time.timeZone = "America/Argentina/Buenos_Aires";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {

    xserver = {
      enable = true;
      layout = "es";

      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+awesome";
      };

      windowManager = {
        awesome = {
		      enable = true;
		      luaModules = with pkgs.luaPackages; [
			      luarocks
		      ];
        };
	    };

    };

    openssh = {
      enable = false;
    };

  };
  
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  users = {
    extraGroups = {
      vboxusers = {
        members = [ "gilberto" ];
      };
    };
    users = {
      gilberto = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" "docker" ];  
        shell = pkgs.zsh;
        initialPassword = "gilberto";
      };
    }; 
  }; 

  environment.systemPackages = 
  with pkgs; 
  let
    php = pkgs.php.buildEnv { extraConfig = "memory_limit = 2G"; };
  in
  [
    wget 
    vim
    htop
    git
    pcmanfm
    pavucontrol
    brave
    lsof
    picom
    lxsession
    zsh
    oh-my-zsh
    psmisc
    pcmanfm
    php
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "exa";
      l = "ls -lah";
      update = "sudo nixos-rebuild switch";
    };
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "sorin";
    };
  };

  virtualisation = {
    docker = {
	    enable = true;
      enableOnBoot = false;
    };
  };

  nixpkgs = {
    config = {
      packageOverrides = pkgs: rec {
        polybar = pkgs.polybar.override {
          i3Support = true;
          pulseSupport = true;
        };
      };
      allowUnfree = true;
    };
  }; 
  
  environment = {
    sessionVariables = {
      XDG_CACHE_HOME  = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME   = "$HOME/.local/share";
      XDG_BIN_HOME    = "$HOME/.local/bin";
    };
    variables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_STYLE_OVERRIDE = "kvantum";
      EDITOR = "vim";
      BROWSER = "brave";
      TERMINAL = "kitty";
      PATH = "$HOME/.emacs.d/bin:$HOME/.bin:$PATH";
    };
  };
  
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts 
    hack-font
    roboto
    (nerdfonts.override { fonts = [ "FiraCode" "UbuntuMono" "JetBrainsMono"]; })
  ];

  system.stateVersion = "21.11"; 
}
