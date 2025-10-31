{ pkgs, ... }:
{
  home = {
    stateVersion = "25.05";
    username = "moskalets";
    homeDirectory = "/home/moskalets";

    packages = with pkgs; [
      git-review
      git-lfs
      freecad
      orca-slicer
      webcamoid
      shotcut
      vlc
      yandex-music
      kicad
      sigrok-cli
      sshfs
      nixos-shell
      md-tui
      git-gr
      google-chrome
      telegram-desktop
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.ru_RU
      vscode
      picocom
    ];
  };

  maxpkgs.employment.enable = true;
  maxpkgs.gui.enable = true;

  programs.bash.enable = true;
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.mouse = 'a'
    '';
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "screen-256color";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
