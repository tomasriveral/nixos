# OLD Deprecated.

{
  config,
  pkgs,
  ...
}:
# same as ./neovim.nix but you vim plug.
# i tried importing my nvim config from fedora to a more nixy way but a lot of settings and plugins didnt work. Maybe i'll fix it latter
# the only difference is the we use :PlugInstall or a similar command before doing anything
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraLuaConfig = ''
      local vim = vim
      -- local Plug = vim.fn['plug#']
      vim.g.mapleader ='ü'
      vim.g.maplocalleader = 'ü'

      -- Set to true if you have a Nerd Font installed and selected in the terminal
      vim.g.have_nerd_font = true

      -- [[ Setting options ]]
      -- See `:help vim.opt`
      -- NOTE: You can change these options as you wish!
      --  For more options, you can see `:help option-list`

      -- Make line numbers default
      -- You can also add relative line numbers, to help with jumping.
      --  Experiment for yourself to see if you like it!
      -- vim.opt.relativenumber = true

      -- Enable mouse mode, can be useful for resizing splits for example!
      vim.opt.mouse = 'a'

      -- Don't show the mode, since it's already in the status line
      vim.opt.showmode = true

      -- Sync clipboard between OS and Neovim.
      --  Schedule the setting after `UiEnter` because it can increase startup-time.
      --  Remove this option if you want your OS clipboard to remain independent.
      --  See `:help 'clipboard'`
      vim.schedule(function()
          vim.opt.clipboard = 'unnamedplus'
      end)


      -- Enable break indent
      vim.opt.breakindent = true

      -- Save undo history
      vim.opt.undofile = true

      -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      -- Keep signcolumn on by default
      vim.opt.signcolumn = 'yes'

      -- Decrease update time
      vim.opt.updatetime = 250

      -- Decrease mapped sequence wait time
      -- Displays which-key popup sooner
      vim.opt.timeoutlen = 300

      -- Configure how new splits should be opened
      vim.opt.splitright = true
      vim.opt.splitbelow = true

      -- Sets how neovim will display certain whitespace characters in the editor.
      --  See `:help 'list'`
      --  and `:help 'listchars'`
      vim.opt.list = true
      vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }



      -- indentation settings - added by me
      -- refere to https://stackoverflow.com/questions/51995128/setting-autoindentation-to-spaces-in-neovim for more information
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4

      -- Preview substitutions live, as you type!
      vim.opt.inccommand = 'split'

      -- Show which line your cursor is on
      vim.opt.cursorline = true

      -- Minimal number of screen lines to keep above and below the cursor.
      vim.opt.scrolloff = 10

      -- [[ Basic Keymaps ]]
      --  See `:help vim.keymap.set()`

      -- Clear highlights on search when pressing <Esc> in normal mode
      --  See `:help hlsearch`
      vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

      -- Diagnostic keymaps
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

      -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
      -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
      -- is not what someone will guess without a bit more experience.
      --
      -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
      -- or just use <C-\><C-n> to exit terminal mode
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

      -- TIP: Disable arrow keys in normal mode
      -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
      -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
      -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
      -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

      -- Keybinds to make split navigation easier.
      --  Use CTRL+<hjkl> to switch between windows
      --
      --  See `:help wincmd` for a list of all window commands
      vim.keymap.set('n', '<C-Left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
      vim.keymap.set('n', '<C-Right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
      vim.keymap.set('n', '<C-Down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
      vim.keymap.set('n', '<C-Up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

      -- jump to next error
      vim.keymap.set("n", "t", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "z", vim.diagnostic.goto_next)


      -- [[ Basic Autocommands ]]
      --  See `:help lua-guide-autocommands`

      -- Highlight when yanking (copying) text
      --  Try it with `yap` in normal mode
      --  See `:help vim.highlight.on_yank()`
      vim.api.nvim_create_autocmd('TextYankPost', {
          desc = 'Highlight when yanking (copying) text',
          group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
          callback = function()
              vim.highlight.on_yank()
          end,
      })

      --require("multiple-cursors").setup({
      --  version = "*",  -- Use the latest tagged version
      --  opts = {},  -- This causes the plugin setup function to be called
      --  keys = {
      --    {"<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "x"}, desc = "Add cursor and move down"},
      --    {"<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "x"}, desc = "Add cursor and move up"},
      --
      --    {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move up"},
      --    {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i", "x"}, desc = "Add cursor and move down"},
      --
      --    {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}, desc = "Add or remove cursor"},
      --
      --    {"<Leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>", mode = {"x"}, desc = "Add cursors to the lines of the visual area"},
      --
      --    {"<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = {"n", "x"}, desc = "Add cursors to cword"},
      --    {"<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = {"n", "x"}, desc = "Add cursors to cword in previous area"},
      --
      --    {"<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Add cursor and jump to next cword"},
      --    {"<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = {"n", "x"}, desc = "Jump to next cword"},
      --
      --    {"<Leader>l", "<Cmd>MultipleCursorsLock<CR>", mode = {"n", "x"}, desc = "Lock virtual cursors"},
      --  },
      --})


      vim.keymap.set("n","§", "<cmd>Cheatsheet<CR>")

      require("cheatsheet").setup({
          bundled_cheatsheets = {
              -- only show the default cheatsheet
              enabled = { "default" },
          },
          bundled_plugin_cheatsheets = {
              -- show cheatsheets for all plugins except gitsigns
              disabled = { "gitsigns.nvim" },
          }
      })



      -- Can be applied to each buffer separately

      local default_options = {
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
          inline = true,
      }


      -- scrollbar
      require("scrollbar").setup()

      -- ufo https://github.com/kevinhwang91/nvim-ufo
      vim.o.foldcolumn = '1' -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      --  Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', '1', "<cmd>foldopen<CR>")
      vim.keymap.set('n', '2', "<cmd>foldclose<CR>")
      vim.keymap.set('n', '3', "<cmd>openAllFold<CR>")
      vim.keymap.set('n', '4', "<cmd> closeAllFold<CR>")
      -- Option 3: treesitter as a main provider instead
      -- (Note: the `nvim-treesitter` plugin is *not* needed.)
      -- ufo uses the same query files for folding (queries/<lang>/folds.scm)
      -- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
      --vim.keymap.set('n', '1', function() require("ufo").foldopen() end, {buffer=0})
      --vim.keymap.set('n', '2', function() require("ufo").foldclose() end)



      -- added by myself
      require('ufo').setup({
          provider_selector = function(bufnr, filetype, buftype)
              return {'treesitter', 'indent'}
          end
      })

      -- Color schemes should be loaded after plug#end().
      vim.o.background = "dark" -- or "light" for light mode
      -- Default options:
      require("gruvbox").setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.cmd("colorscheme gruvbox")
      -- nvim-tree https://github.com/nvim-tree/nvim-tree.lua
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- optionally enable 24-bit colour
      vim.opt.termguicolors = true


      -- setup with some options
      require("nvim-tree").setup({
          sort = {
              sorter = "case_sensitive",
          },
          view = {
              width = 30,
          },
          renderer = {
              group_empty = true,
          },
          filters = {
              dotfiles = true,
         },
      })
      vim.opt.number = true
      -- Uncomment for opening the navigable tree file systeme on startup of NeoVim
      --vim.cmd('NvimTreeOpen')

      require('md-pdf').setup({
          --- Set margins around document
          margins = "1.5cm",
          -- tango, pygments are quite nice for white on white
          highlight = "tango",
          -- Generate a table of contents, on by default
          toc = true,
          -- Define a custom preview command, enabling hooks and other custom logic
          preview_cmd = function() return 'firefox' end,
          -- if true, then the markdown file is continuously converted on each write, even if the
          -- file viewer closed, e.g., firefox is "closed" once the document is opened in it.
          ignore_viewer_state = false,
          -- Specify font, `nil` uses the default font of the theme
          fonts = nil,
          -- or, where all or only some options can be specified. NOTE: those that are `nil` can be left
          -- out completely
          fonts = {
              main_font = nil,
              sans_font = "DejaVuSans",
              mono_font = "IosevkaTerm Nerd Font Mono",
              math_font = nil,
          },
          -- Custom options passed to `pandoc` CLI call, can be ignored for setup
          pandoc_user_args = nil,
          -- or
          pandoc_user_args = {
              -- short
              "-V KEY[:VALUE]",
              -- long options
              "--standalone=[true|false]",
          },
          --- Path to output. Needs to be always relative, e.g.: "./", "../", "./out" or simply "out", but
          --- not absolute e.g.: "/"!
          output_path = "",
      })

      -- setup mapping
      vim.keymap.set("n", "<Space>,", function()
          require('md-pdf').convert_md_to_pdf()
      end)
        -- Set up nvim-cmp.
        local cmp = require'cmp'

        cmp.setup({
          snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
              vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
              -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
              -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
              -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
              -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
            end,
          },
          window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
          }, {
            { name = 'buffer' },
          })
        })

        -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
        -- Set configuration for specific filetype.
        --[[ cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'git' },
          }, {
            { name = 'buffer' },
          })
       })
       require("cmp_git").setup() ]]--

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          }),
          matching = { disallow_symbol_nonprefix_matching = false }
        })


        -- require(lspconfig) is deprecated
      --  -- Set up lspconfig.
      --  local capabilities = require('cmp_nvim_lsp').default_capabilities()
      --  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      --  require('lspconfig')['texlab'].setup {
      --    capabilities = capabilities
      --  }
      --require'lspconfig'.clangd.setup{}
      --lspconfig = require("lspconfig")
      --lspconfig.pylsp.setup {
      --on_attach = custom_attach,
      --settings = {
      --    pylsp = {
      --    plugins = {
      --        -- formatter options
      --        black = { enabled = true },
      --        autopep8 = { enabled = false },
      --        yapf = { enabled = false },
      --        -- linter options
      --        pylint = { enabled = true, executable = "pylint" },
      --        pyflakes = { enabled = false },
      --        pycodestyle = { enabled = false },
      --        -- type checker
      --        pylsp_mypy = { enabled = true },
      --        -- auto-completion options
      --        jedi_completion = { fuzzy = true },
      --        -- import sorting
      --        pyls_isort = { enabled = true },
      --    },
      --    },
      --},
      --flags = {
      --    debounce_text_changes = 200,
      --},
      --capabilities = capabilities,
      --}
      ---- lua-lsp
      --require'lspconfig'.lua_ls.setup{}
      --
      --new version
      -- ============================
      -- LSP CONFIGURATION (Neovim 0.11+)
      -- ============================

      -- Set up capabilities for nvim-cmp LSP completion
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Optional: custom on_attach function if you have keymaps
      -- local custom_attach = function(client, bufnr)
      --     -- your on_attach code here
      -- end

      -- Utility function to simplify server setup
      local function setup_lsp(server_name, opts)
        vim.lsp.config(server_name, opts or {})
      end

      -- ======== LSP SERVERS ========

      -- TeXLab
      setup_lsp("texlab", {
        capabilities = capabilities,
      })

      -- Clangd (C/C++)
      setup_lsp("clangd", {
        capabilities = capabilities,
      })

      -- Python LSP (pylsp)
      setup_lsp("pylsp", {
        on_attach = custom_attach,
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 200,
        },
        settings = {
          pylsp = {
            plugins = {
              -- Formatter options
              black = { enabled = true },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              -- Linter options
              pylint = { enabled = true, executable = "pylint" },
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              -- Type checker
              pylsp_mypy = { enabled = true },
              -- Auto-completion options
              jedi_completion = { fuzzy = true },
              -- Import sorting
              pyls_isort = { enabled = true },
            },
          },
        },
      })

      -- Lua LSP
      setup_lsp("lua_ls", {
        capabilities = capabilities,
      })


      -- dashboard config
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
        shortcut = {
      	      { desc = "  Open File Tree", group = "", key = 't', action = 'NvimTreeOpen' },
          -- action can be a function type
        },
        packages = { enable = false }, -- show how many plugins neovim loaded
        -- limit how many projects list, action when you press key or enter it will run this action.
        -- action can be a functino type, e.g.
        -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
        project = { enable = true, limit = 8, icon = '  New file', label = "", action = 'Telescope find_files cwd=' },
        mru = { limit = 10, icon = '  History', label = "", cwd_only = false },
        footer = {}, -- footer
      }
      }

      -- lualine config https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/bubbles.lua
      require('lualine').setup {
        options = { theme  = "gruvbox_dark" },
      }
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

    '';
  };
}
