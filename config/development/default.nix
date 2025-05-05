{ config, pkgs, ... }:

{
  imports = [
    ./git
    ./printing
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
