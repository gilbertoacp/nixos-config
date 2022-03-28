{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [

      # theme - appearance
      lxappearance
      libsForQt5.qtstyleplugin-kvantum
      papirus-icon-theme
      materia-theme
      bat
      exa
      (polybar.override {
        i3Support = true;
        pulseSupport = true;
      })

      # terms
      kitty

      # desktop utils
      onlyoffice-bin
      ripgrep
      evince
      neofetch
      imwheel
      gnome.file-roller
      xdg-user-dirs
      rofi
      pcmanfm
      nitrogen

      # development
      emacs
      vscode
      android-studio
      zsh

      # browsers
      firefox
      google-chrome

      # mail      
      mailspring

      # multimedia
      simplescreenrecorder
      obs-studio
      pragha
      sxiv

      # misc
      fzf
      fd
      bitwarden
      postman
      picom
    ];
  }; 

  programs = {
    home-manager = { enable = true; };

    neovim = {
      enable = true;
      vimAlias = true;
    };

    git = {
      enable = true;
      userName = "Gilberto Calderón";
      userEmail = "calderongilberto3@gmail.com";
      aliases = {
        st = "status";
        ci = "commit";
        co = "checkout";
        tm = "merge --no-ff --no-commit";
        pp = "!git pull && git push";
        rm-untracked = "!rm $(git ls-files --other --exclude-standard)";
        lsblame = "!cd \"./$GIT_PREFIX\" && ls -A | xargs -n1 -I'{}' git log --no-merges --format='%h (%an%x09%ai) {}' -1 '{}' | column -ts $'\t'";
        df = "diff";
      };
      extraConfig = {
        credential = { helper = "store"; };
      };
    };

    zsh = {
      enable = true;
      enableSyntaxHighlighting = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = {
        ls = "exa";
        ll = "ls -lah";
        psmem = "ps auxf | sort -nr -k 4 | head -5";
        pscpu = "ps auxf | sort -nr -k 3 | head -5";
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "fzf" ];
        theme = "gentoo";
      };
    };
  };
}
