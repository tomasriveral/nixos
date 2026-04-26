{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = false;
    viAlias = false;
    package = pkgs-unstable.neovim-unwrapped; # required for unwrapped version
    plugins = [
      pkgs-unstable.vimPlugins.vivify-vim
      pkgs-unstable.vimPlugins.vimtex
      pkgs-unstable.vimPlugins.zoxide-vim
      #pkgs-unstable.vimPlugins.gruvbox
      pkgs-unstable.vimPlugins.gruvbox-nvim
      pkgs-unstable.vimPlugins.neovim-sensible
      pkgs-unstable.vimPlugins.nvim-web-devicons
      pkgs-unstable.vimPlugins.nvim-tree-lua
      pkgs-unstable.vimPlugins.nvim-surround
      pkgs-unstable.vimPlugins.floaterm
      pkgs-unstable.vimPlugins.nvim-lspconfig
      pkgs-unstable.vimPlugins.cmp-nvim-lsp
      pkgs-unstable.vimPlugins.cmp-nvim-lsp-signature-help
      pkgs-unstable.vimPlugins.cmp-under-comparator
      pkgs-unstable.vimPlugins.cmp-buffer
      pkgs-unstable.vimPlugins.cmp-path
      pkgs-unstable.vimPlugins.cmp-cmdline
      pkgs-unstable.vimPlugins.nvim-cmp
      pkgs-unstable.vimPlugins.cmp-vsnip
      pkgs-unstable.vimPlugins.vim-vsnip
      pkgs-unstable.vimPlugins.dashboard-nvim
      pkgs-unstable.vimPlugins.lualine-nvim
      pkgs-unstable.vimPlugins.vim-nix
      pkgs-unstable.vimPlugins.plenary-nvim
      pkgs-unstable.vimPlugins.blink-ripgrep-nvim
      pkgs-unstable.vimPlugins.nvim-treesitter
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.rasi
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.regex
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.udev
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.zsh
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.c
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.bibtex
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.bash
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.gitignore
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.comment
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.json
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.hyprlang
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.lua
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.latex
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.kitty
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.markdown
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.nix
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.printf
      pkgs-unstable.vimPlugins.nvim-treesitter-parsers.python
      pkgs-unstable.vimPlugins.telescope-nvim
      pkgs-unstable.vimPlugins.nvim-scrollbar
      pkgs-unstable.vimPlugins.promise-async
      pkgs-unstable.vimPlugins.nvim-ufo
      pkgs-unstable.vimPlugins.cheatsheet-nvim
      pkgs-unstable.vimPlugins.popup-nvim
      pkgs-unstable.vimPlugins.vim-visual-multi
      pkgs-unstable.vimPlugins.fugit2-nvim
      pkgs-unstable.vimPlugins.nvim-lastplace
      pkgs-unstable.vimPlugins.runner-nvim # terminal
      pkgs-unstable.vimPlugins.better-diagnostic-virtual-text
      pkgs-unstable.vimPlugins.garbage-day-nvim
    ];
    extraLuaConfig = ''

            local vim = vim

            -- =========================
            -- LEADER & KEY DISABLE
            -- =========================
            vim.g.mapleader = ' '
            vim.g.maplocalleader = ' '
            vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', { desc = 'Leader key, disable default behavior' })
            vim.keymap.set('n', 'q', '<Nop>', { desc = 'Disable macro recording' })
      vim.keymap.set('n', 'gg', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gG', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g0', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g^', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g$', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gj', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gk', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g~', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gu', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gU', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g=', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gq', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g@', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g?', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gC', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gD', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gx', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'gr', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g[', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g]', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g;', '<Nop>', { desc = 'Disable g motion' })
      vim.keymap.set('n', 'g,', '<Nop>', { desc = 'Disable g motion' })
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


            -- =========================
            -- BASIC KEYMAPS
            -- =========================
            vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
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

            -- ========================
            -- terminal
            -- =======================
            require("runner-nvim").setup({
              position = 'right', -- position of the terminal window when using the shell_handler
                            -- can be: top, left, right, bottom
                            -- will be overwritten when using the telescope mapping to open horizontally or vertically

              width = 80,         -- width of window when position is left or right
              height = 10,        -- height of window when position is top or bottom

              handlers = {
                lua = function(bufnr)
                  vim.print('Running lua file in buffer ' .. bufnr)
                  -- Run the file here
                end
            }
            })

            vim.keymap.set("n", "<leader><leader>", function() require("runner-nvim").run() end)
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
            vim.keymap.set('n', '<leader>1', "<cmd>foldopen<CR>")
            vim.keymap.set('n', '<leader>2', "<cmd>foldclose<CR>")
            require('ufo').setup({
                provider_selector = function() return {'treesitter', 'indent'} end
            })

            -- =========================
            -- treesitter
            -- ========================
            require('nvim-treesitter').setup({
        ensure_installed = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
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

          -- Diagnostics
          vim.keymap.set("n", "<leader>e1", function() vim.diagnostic.jump({ prev=true, count = 1 }) end, { desc = "Previous diagnostic" })
          vim.keymap.set("n", "<leader>e2", function() vim.diagnostic.jump({ prev=false, count = 1 }) end, { desc = "Next diagnostic" })
          vim.keymap.set("n", "<leader>e3", vim.diagnostic.open_float, { desc = "Show diagnostic" })
          vim.keymap.set("n", "<leader>e4", vim.diagnostic.setloclist, { desc = "Diagnostic list" })

            vim.diagnostic.config({
        update_in_insert = false, -- i don't get any new error when in insert
          })
            require("better-diagnostic-virtual-text").setup({
          ui = {
              wrap_line_after = false, -- wrap the line after this length to avoid the virtual text is too long
              left_kept_space = 3, --- the number of spaces kept on the left side of the virtual text, make sure it enough to custom for each line
              right_kept_space = 3, --- the number of spaces kept on the right side of the virtual text, make sure it enough to custom for each line
              arrow = "  ",
              up_arrow = "  ",
              down_arrow = "  ",
              above = false, -- the virtual text will be displayed above the line
          },
          priority = 2003, -- the priority of virtual text
          inline = false,

            })


          -- LSP functionality
          vim.keymap.set("n", "<leader>g1", vim.lsp.buf.hover, { desc = "Hover documentation" })
          vim.keymap.set("n", "<leader>g2", vim.lsp.buf.definition, { desc = "Go to definition" })
          vim.keymap.set("n", "<leader>g3", vim.lsp.buf.declaration, { desc = "Go to declaration" })
          vim.keymap.set("n", "<leader>g4", vim.lsp.buf.implementation, { desc = "Go to implementation" })
          vim.keymap.set("n", "<leader>g5", vim.lsp.buf.references, { desc = "Show references" })

      -- LSP server setup
      vim.lsp.config("lua_ls", { cmd = { "lua-language-server" }, filetypes = { "lua" }, root_dir = vim.fs.dirname, on_attach = on_attach })
          vim.lsp.config("clangd", {
            cmd = { "clangd" },
            filetypes = { "c","cpp","objc","objcpp" },
            on_attach = on_attach ,
              init_options = {
          clangdFileStatus = true,
          usePlaceholders = true,
          completeUnimported = false, -- this adds a bunch of #include even thought they are #included in another header file
          headerInsertion = false,
          headerInsertionDecorators = false,
          semanticHighlighting = true}
            })
            vim.lsp.config("nixd", {
              cmd = { "nixd" },
              filetyypes = { "nix" },
              on_attach = on_attach,
            })
      vim.lsp.config("pylsp", {
          cmd = { "pylsp" },
          filetypes = { "python" },
          on_attach = on_attach,
          settings = {
              pylsp = {
                  plugins = {
                      pylsp_mypy = { enabled = true },
                      jedi_completion = { fuzzy = true }
                  }
              }
          }
      })
      vim.lsp.config("texlab", { cmd = { "texlab" }, filetypes = { "tex" }, on_attach = on_attach })

      vim.lsp.enable({ "lua_ls", "clangd", "pylsp", "texlab", "nixd"})
            -- =========================
            -- DASHBOARD
            -- =========================
            require('dashboard').setup {
              theme = 'hyper',
              config = {
              header = {
            	"     ...     ...                                                    .                        ",
            	"  .=*8888n..\"%888:                                                 @88>                      ",
                    " X    ?8888f '8888                     u.        ...     ..        %8P      ..    .     :    ",
            	" 88x. '8888X  8888>       .u     ...ue888b    :~\"\"888h.:^\"888:      .     .888: x888  x888.  ",
            	"'8888k 8888X  '\"*8h.   ud8888.   888R Y888r  8X   `8888X  8888>   .@88u  ~`8888~'888X`?888f` ",
            	" \"8888 X888X .xH8    :888'8888.  888R I888> X888n. 8888X  ?888>  '\"888E`   X888  888X '888>  ",
                    "   `8\" X888!:888X    d888 '88%\"  888R I888> '88888 8888X   ?**h.   888E    X888  888X '888>  ",
            	"  =~`  X888 X888X    8888.+\"     888R I888>   `*88 8888~ x88x.     888E    X888  888X '888>  ",
            	"   :h. X8*` !888X    8888L      u8888cJ888   ..<\"  88*`  88888X    888E    X888  888X '888>  ",
            	"  X888xX\"   '8888..: '8888c. .+  \"*888*P\"       ..XC.    `*8888k   888&   \"*88%\"\"*88\" '888!` ",
                    ":~`888f     '*888*\"   \"88888%      'Y\"        :888888H.    `%88>   R888\"    `~    \"    `\"`   ",
            	"    \"\"        `\"`       \"YP'                 <  `\"888888:    X\"     \"\"                       ",
            	"                                                   %888888x.-`                               ",
            	"                                                     \"\"**\"\"                                  ",
                    "",
            	""
            },
                shortcut = { { desc = "  Open File Tree", group = "", key = 't', action = 'NvimTreeOpen' } },
                packages = { enable = false },
                project = { enable = true, limit = 8, icon = '  New file', action = 'Telescope find_files cwd=' },
                mru = { limit = 10, icon = '  History' },
                footer = {},
              }
            }

            -- jumps cursor when was last cursor last time
            require("nvim-lastplace").setup({
              -- Filetypes to ignore
              ignore_filetypes = {
                "gitcommit", "gitrebase", "svn", "hgcommit", "xxd", "COMMIT_EDITMSG"
              },

              -- Buffer types to ignore
              ignore_buftypes = {
                "quickfix", "nofile", "help", "terminal"
              },

              -- Center cursor after jumping
              center_on_jump = true,

              -- Only jump if target line is not visible
              jump_only_if_not_visible = false,

              -- Minimum lines required to enable jumping
              min_lines = 10,

              -- Maximum line to jump to (0 = no limit)
              max_line = 0,

              -- Open folds after jumping
              open_folds = true,

              -- Enable debug messages
              debug = false,
            })
            -- ======================
            -- gruvbox
            -- ======================

            require("gruvbox").setup({
              terminal_colors = false, -- add neovim terminal colors
              undercurl = true,
              underline = true,
              bold = true,
              italic = {
                strings = false,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
              },
              strikethrough = true,
              invert_selection = false,
              invert_signs = false,
              invert_tabline = false,
              inverse = true, -- invert background for search, diffs, statuslines and errors
              contrast = "hard", -- can be "hard", "soft" or empty string
              palette_overrides = {  -- for overrides see https://github.com/ellisonleao/gruvbox.nvim/blob/main/lua/gruvbox.lua
                dark0_hard = "#241F17"
              },
              overrides = {
                String = {fg = "#FFB878", italic = false},
                FoldColumn = {fg = faded_orange, bg = dark0_hard}
              },
              dim_inactive = false,
              transparent_mode = false,
            })
            vim.opt.termguicolors = false
            vim.o.background = "dark"
            vim.cmd("colorscheme gruvbox")
            -- =========================
            -- LUALINE
            -- =========================
            require('lualine').setup { options = { theme  = "gruvbox_dark" } }


            --==================0
            -- Some utils
            --==================
            vim.keymap.set('n', '<leader>r1', '<cmd>Fugit2<CR>', { desc = 'Open git helper' })

            -- =========================
            -- telescope
            -- =======================
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>f1', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>f2', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>f3', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>f4', builtin.help_tags, { desc = 'Telescope help tags' })

            -- Disable relative numbers even if plugins override
            vim.api.nvim_create_autocmd("VimEnter", { callback = function() vim.opt.colorcolumn = ""; vim.opt.relativenumber = false end })
    '';
  };
}
