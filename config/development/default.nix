{ config, pkgs, ... }:

{
  imports = [ ./git ./printing ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [ vscode picocom ];
}
