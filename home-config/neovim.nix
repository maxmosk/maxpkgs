{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    initLua = ''
      vim.opt.number = true
      vim.opt.mouse = 'a'
      vim.opt.expandtab = true
    '';
  };
}
