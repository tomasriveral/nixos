{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {

  programs.neovim = {
    enable = true;
    vimAlias = false;
    viAlias = true;
    package = pkgs-unstable.neovim-unwrapped; # required for unwrapped version
    plugins = [
      pkgs-unstable.vimPlugins.vivify-vim
      pkgs.vimPlugins.vimtex
      pkgs.vimPlugins.zoxide-vim
      pkgs.vimPlugins.gruvbox
      pkgs.vimPlugins.neovim-sensible
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.nvim-tree-lua
      pkgs.vimPlugins.nvim-surround
      pkgs.vimPlugins.floaterm
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-buffer
      pkgs.vimPlugins.cmp-path
      pkgs.vimPlugins.cmp-cmdline
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.cmp-vsnip
      pkgs.vimPlugins.vim-vsnip
      pkgs.vimPlugins.dashboard-nvim
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.blink-ripgrep-nvim
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.nvim-scrollbar
      pkgs.vimPlugins.promise-async
      pkgs.vimPlugins.nvim-ufo
      pkgs.vimPlugins.cheatsheet-nvim
      pkgs.vimPlugins.popup-nvim
      pkgs.vimPlugins.vim-visual-multi
    ];
    extraLuaConfig = ''
      local vim = vim

      -- =========================
      -- LEADER & KEY DISABLE
      -- =========================
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '
      vim.keymap.set('n', 'q', '<Nop>', { desc = 'Disable macro recording' })

      -- =========================
      -- GENERAL OPTIONS
      -- =========================
      vim.g.have_nerd_font = true
      vim.opt.relativenumber = false
      vim.opt.number = true
      vim.opt.mouse = 'a'
      vim.opt.showmode = false
      vim.schedule(function()
          vim.opt.clipboard = 'unnamedplus'
      end)
      vim.opt.breakindent = true
      vim.opt.undofile = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.signcolumn = 'yes'
      vim.opt.updatetime = 250
      vim.opt.timeoutlen = 300
      vim.opt.splitright = true
      vim.opt.splitbelow = true
      vim.opt.list = true
      vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.inccommand = 'split'
      vim.opt.cursorline = true
      vim.opt.scrolloff = 10
      vim.opt.termguicolors = true
      vim.o.background = "dark"
      vim.cmd("colorscheme gruvbox")

      -- =========================
      -- BASIC KEYMAPS
      -- =========================
      vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

      -- Disable arrow keys in normal mode
      vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
      vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
      vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
      vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

      -- Window navigation
      vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
      vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
      vim.keymap.set('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
      vim.keymap.set('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

      -- Diagnostic navigation
      vim.keymap.set("n", "t", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "z", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic" })

      -- Cheatsheet
      vim.keymap.set("n","§", "<cmd>Cheatsheet<CR>")
      require("cheatsheet").setup({
          bundled_cheatsheets = { enabled = { "default" } },
          bundled_plugin_cheatsheets = { disabled = { "gitsigns.nvim" } }
      })

      -- Highlight yanked text
      vim.api.nvim_create_autocmd('TextYankPost', {
          desc = 'Highlight on yank',
          group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
          callback = function() vim.highlight.on_yank() end,
      })

      -- =========================
      -- SCROLLBAR
      -- =========================
      require("scrollbar").setup()

      -- =========================
      -- UFO FOLDING
      -- =========================
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.keymap.set('n', '1', "<cmd>foldopen<CR>")
      vim.keymap.set('n', '2', "<cmd>foldclose<CR>")
      require('ufo').setup({
          provider_selector = function() return {'treesitter', 'indent'} end
      })

      -- =========================
      -- NVIM-TREE
      -- =========================
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      require("nvim-tree").setup({
          sort = { sorter = "case_sensitive" },
          view = { width = 30 },
          renderer = { group_empty = true },
          filters = { dotfiles = true },
      })

      -- =========================
      -- CMP CONFIGURATION
      -- =========================
      local cmp = require'cmp'
      cmp.setup({
        snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'vsnip' } }, { { name = 'buffer' } }),
      })

      cmp.setup.cmdline({ '/', '?' }, { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })
      cmp.setup.cmdline(':', { mapping = cmp.mapping.preset.cmdline(), sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }), matching = { disallow_symbol_nonprefix_matching = false } })

      -- =========================
      -- LSP CONFIGURATION
      -- =========================
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local function on_attach(client, bufnr)
          local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          map("n", "t", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("n", "z", vim.diagnostic.goto_next, "Next diagnostic")
          map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")
          map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostic list")
          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")
      end

      vim.lsp.config("lua_ls", { cmd = { "lua-language-server" }, filetypes = { "lua" }, root_dir = vim.fs.dirname, on_attach = on_attach })
      vim.lsp.config("clangd", { cmd = { "clangd" }, filetypes = { "c","cpp","objc","objcpp" }, on_attach = on_attach })
      vim.lsp.config("pylsp", { cmd = { "pylsp" }, filetypes = { "python" }, on_attach = on_attach, settings = { pylsp = { plugins = { pylsp_mypy = { enabled = true }, jedi_completion = { fuzzy = true } } } } })
      vim.lsp.config("texlab", { cmd = { "texlab" }, filetypes = { "tex" }, on_attach = on_attach })
      vim.lsp.enable({ "lua_ls", "clangd", "pylsp", "texlab" })

      -- =========================
      -- DASHBOARD
      -- =========================
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          header = { "  ...  ASCII ART ...  " },
          shortcut = { { desc = "  Open File Tree", group = "", key = 't', action = 'NvimTreeOpen' } },
          packages = { enable = false },
          project = { enable = true, limit = 8, icon = '  New file', action = 'Telescope find_files cwd=' },
          mru = { limit = 10, icon = '  History' },
          footer = {},
        }
      }

      -- =========================
      -- LUALINE
      -- =========================
      require('lualine').setup { options = { theme  = "gruvbox_dark" } }

      -- =========================
      -- TELESCOPE
      -- =========================
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

      -- Disable relative numbers even if plugins override
      vim.api.nvim_create_autocmd("VimEnter", { callback = function() vim.opt.colorcolumn = ""; vim.opt.relativenumber = false end })
    '';
  };
}
