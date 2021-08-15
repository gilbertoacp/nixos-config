{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixUnstable;
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
        lightdm = {
	  enable = true;
        };
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
    	extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" ];  
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
     emacs
     htop
     neofetch
     git
     lxappearance
     pcmanfm
     pavucontrol
     kitty
     brave
     unrar
     unzip
     zip 
     p7zip
     lsof
     imwheel
     mpv
     rofi
     polybar   
     vscodium
     libreoffice
     arc-theme
     arc-icon-theme
     nitrogen
     ripgrep
     fd
     simplescreenrecorder
     picom
     lxsession
     dunst 
     zsh
     oh-my-zsh
     psmisc
     exa
     bat
     pcmanfm
     sxiv
     libsForQt5.qtstyleplugin-kvantum
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
  
  environment.variables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_STYLE_OVERRIDE = "kvantum";
    EDITOR = "vim";
    BROWSER = "brave";
    TERMINAL = "kitty";
    PATH = "$HOME/.emacs.d/bin:$HOME/.bin:$PATH";
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
  
  services = {
    openssh = {
      enable = true;
    };
  };
  system.stateVersion = "21.11"; 

}
