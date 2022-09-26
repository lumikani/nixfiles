{ pkgs, lib, ... }:
let
  customPlugins = {
    winresizer = pkgs.vimUtils.buildVimPlugin {
      name = "winresizer";
      src = pkgs.fetchgit {
        url = "https://github.com/simeji/winresizer";
        rev = "9dc9899cedf84d78b93263b1fdb105b37c54c7b5";
        sha256 = "hT0eaOTUk3F2U8iBNv5hLbNPeyWK2mltZxK87laR21A=";
      };
      meta = {
        homepage = "https://github.com/simeji/winresizer";
        maintainers = [ "simeji" ];
      };
    };
  };
  allPlugins = pkgs.vimPlugins // customPlugins;
in
{
  home.packages = with pkgs; [
    xclip
  ];

  programs.neovim = {
    enable = true;

    extraConfig =
      ''
        "No file clutter
        set nobackup
        set nowb
        set noswapfile

        let mapleader = ' '

        "Scroll before reaching end of page
        set scrolloff=5
        set encoding=utf-8

        set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
        set number
        set autoindent
        set mouse=a
        set termguicolors

        vnoremap <silent><leader>y "+y
        nnoremap <leader>se :NvimTreeFindFileToggle<CR>
        nnoremap <leader>r :NvimTreeRefresh<CR>
        nnoremap <leader>n :NvimTreeFindFile<CR>
        command! RenameWindow silent !xdotool getwindowfocus set_window --name "nvim - $(basename $PWD)"

        :RenameWindow
      '';

    plugins = with allPlugins; [
      vim-nix
      vim-fugitive
      editorconfig-nvim
      plenary-nvim
      nvim-web-devicons
      winresizer
      vim-vsnip
      cmp-nvim-lsp

      # Plugins with custom config
      {
        plugin = fzf-vim;
        config = ''
            nnoremap <C-p> :FZF<Cr>
            nnoremap <C-g> :Rg<Cr>
          '';
      }

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
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config =
          ''
            local lspconfig = require('lspconfig')

            local buf_map = function(bufnr, mode, lhs, rhs, opts)
              vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
                silent = true,
              })
            end
            
            local on_attach = function(client, bufnr)
              vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
              vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
              vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
              vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
              vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
              vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
              vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
              vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
              vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
              vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
              vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
              vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
              buf_map(bufnr, "n", "gd", ":LspDef<CR>")
              buf_map(bufnr, "n", "gr", ":LspRename<CR>")
              buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
              buf_map(bufnr, "n", "K", ":LspHover<CR>")
              buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
              buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
              buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
              buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
              buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
              if client.resolved_capabilities.document_formatting then
                vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
              end
            end

            lspconfig.tsserver.setup({
              on_attach = function(client, bufnr)
                client.resolved_capabilities.document_formatting = false
                client.resolved_capabilities.document_range_formatting = false
                local ts_utils = require("nvim-lsp-ts-utils")
                ts_utils.setup({})
                ts_utils.setup_client(client)
                buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
                buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
                buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
                capabilities = capabilities,
                on_attach(client, bufnr)
              end,
            })

            lspconfig.hls.setup({
                capabilities = capabilities,
                settings = {
                  haskell = {
                    formattingProvider = "stylish-haskell",
                  },
                },
                on_attach = on_attach
            })

            lspconfig.yamlls.setup {
              capabilities = capabilities,
              settings = {
                yaml = {
                  schemas = {
                    kubernetes = "*.yaml"
                  },
                },
              },
              on_attach = on_attach
            }
          '';
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config =
          ''
            local cmp = require'cmp'

            cmp.setup({
              snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                  vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                end,
              },
              mapping = {
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                ['<C-e>'] = cmp.mapping({
                  i = cmp.mapping.abort(),
                  c = cmp.mapping.close(),
                }),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              },
              sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' }, -- For vsnip users.
              }, {
                { name = 'buffer' },
              })
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
              sources = cmp.config.sources({
                { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
              }, {
                { name = 'buffer' },
              })
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
              sources = {
                { name = 'buffer' }
              }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
              sources = cmp.config.sources({
                { name = 'path' }
              }, {
                { name = 'cmdline' }
              })
            })

            -- Setup lspconfig.
            local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

            require('lspconfig').pylsp.setup{
              capabilities = capabilities,
              on_attach = on_attach,
              settings = {
                configurationSources = {'flake8'},
                plugins = {
                  pycodestyle = {
                    enabled = false
                  },
                  mccabe = {
                    enabled = false
                  },
                  pyflake = {
                    enabled = false
                  },
                  flake8 = {
                    enabled = true,
                    config = '.flake8'
                  }
                }
              }
            }

            require('lspconfig')['tsserver'].setup {
              capabilities = capabilities,
              on_attach = on_attach
            }

            require('lspconfig')['hls'].setup {
              capabilities = capabilities,
              settings = {
                haskell = {
                  formattingProvider = "stylish-haskell",
                },
              },
              on_attach = on_attach
            }

            require('lspconfig')['yamlls'].setup {
              capabilities = capabilities,
              settings = {
                yaml = {
                  schemas = {
                    kubernetes = "*.yaml"
                  },
                },
              },
              on_attach = on_attach
            }
          '';
      }
      {
        plugin = null-ls-nvim;
        type = "lua";
        config =
          ''
            local null_ls = require("null-ls")

            null_ls.setup({
              sources = {
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.code_actions.eslint_d,
                null_ls.builtins.formatting.prettier.with({
                  filetypes = {
                    "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "jsonc", "markdown", "graphql", "handlebars", "yaml"
                  }
                })
              },
              on_attach = on_attach
            })
          '';
      }
    ];
  };
}

