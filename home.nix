{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "gilberto";
  home.homeDirectory = "/home/gilberto";

  home.packages = with pkgs; [
    kitty
    bat
    exa
  ];

  programs.neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
      	vim-nix
      ];
  };
  home.stateVersion = "21.11";
}
