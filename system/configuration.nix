{ config, pkgs, ... }:

{
  imports =
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
        defaultSession = "none+i3";
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
      };   
    };
    openssh = {
      enable = true;
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
        extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" "docker"];  
        shell = pkgs.zsh;
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
    mpv
    rofi
    arc-theme
    arc-icon-theme
    vscode
    nitrogen
    ripgrep
    fd
    picom
    lxsession
    dunst 
    zsh
    oh-my-zsh
    psmisc
    pcmanfm
    php
    gnumake
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
    variables = {
        _JAVA_AWT_WM_NONREPARENTING = "1";
        QT_STYLE_OVERRIDE = "kvantum";
        EDITOR = "vim";
        BROWSER = "brave";
        TERMINAL = "kitty";
        PATH = "$HOME/.emacs.d/bin:$HOME/.bin:$PATH";
    };
    sessionVariables = {
        XDG_CACHE_HOME  = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME   = "$HOME/.local/share";
        XDG_BIN_HOME    = "$HOME/.local/bin";
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
