{ config, pkgs, ... }:

{
  imports = [ ./git ./printing ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      packages.all.start = with pkgs.vimPlugins;
        [ nvim-treesitter.withAllGrammars ];
    };
  };

  environment.systemPackages = with pkgs; [ vscode picocom ];
}
