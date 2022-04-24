{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclip
  ];

  programs.neovim = {
    enable = true;

    extraConfig =
      ''
        let mapleader = ' '

        set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
        set number
        set autoindent
        set mouse=a
        set termguicolors

        vnoremap <silent><leader>y "+y
        nnoremap <leader>se :NvimTreeFindFileToggle<CR>
        nnoremap <leader>r :NvimTreeRefresh<CR>
        nnoremap <leader>n :NvimTreeFindFile<CR>
      '';

    plugins = with pkgs.vimPlugins; [
      vim-nix
      editorconfig-nvim
      plenary-nvim
      nvim-web-devicons

      # Plugins with custom config
      {
        plugin = vim-gitgutter;
        config =
          ''
            let g:gitgutter_sign_added = '✚'
            let g:gitgutter_sign_modified = '✹'
            let g:gitgutter_sign_removed = '-'
            let g:gitgutter_sign_removed_first_line = '-'
            let g:gitgutter_sign_modified_removed = '-'
          '';
      }

      {
        plugin = nvim-tree-lua;
        type = "lua";
        config =
          ''
            require'nvim-tree'.setup {}
          '';
      }

      # Theme
      {
        plugin = tokyonight-nvim;
        config =
          ''
          let g:tokyonight_style = "night"
          colorscheme tokyonight
          '';
      }
    ];
  };
}

