{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "gilberto";
    homeDirectory = "/home/gilberto";
    packages = with pkgs; [
      kitty
      bat
      exa
      xdg-user-dirs
      gtop
      neofetch
      lxappearance
      imwheel
      simplescreenrecorder
      materia-theme
      papirus-icon-theme
      libsForQt5.qtstyleplugin-kvantum
      emacs
      libreoffice
      sxiv
      unrar
      unzip
      zip 
      p7zip
    ];
    stateVersion = "20.09";
  }; 

  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
      ];
    };
    gpg = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "Gilberto Calderón";
      userEmail = "calderongilberto3@gmail.com";
    };
  };
}
