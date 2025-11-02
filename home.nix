{ pkgs, lib, ... }:
{
  home = {
    stateVersion = "25.05";
    username = "moskalets";
    homeDirectory = "/home/moskalets";

    packages = with pkgs; [
      vlc
      yandex-music
      google-chrome
      telegram-desktop
    ];
  };

  maxpkgs.employment.enable = true;
  maxpkgs.gui.enable = true;
  maxpkgs.blog.enable = true;

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
