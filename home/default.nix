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
    ];
    stateVersion = "21.11";
  }; 

  programs = {
    neovim = {
      enable = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
      ];
    };
  };
}
