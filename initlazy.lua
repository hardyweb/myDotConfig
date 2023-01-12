local lazypath = vim.fn.stdpath("data") .."/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
	"git",
	"clone",
	"--filter=blob:none",
	"https://github.com/folke/lazy.nvim.git",
	"--branch=stable",
	lazypath

	})

end 
vim.opt.rtp:prepend(lazypath)

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ''
vim.g.maplocalleader = ' '
vim.g.user_emmet_leader_key=','


require('lazy').setup({
--  'wbthomason/packer.nvim', -- Package manager
  'tpope/vim-fugitive', -- Git commands in nvim
  'tpope/vim-rhubarb', -- Fugitive-companion to interact with github
  'tpope/vim-commentary', -- "gc" to comment visual regions/lines
  'ludovicchabant/vim-gutentags', -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
   { 'nvim-telescope/telescope.nvim', dependencies = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } } },
  'joshdick/onedark.vim', -- Theme inspired by Atom
  'itchyny/lightline.vim', -- Fancier statusline
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  -- Add git related info in the signs columns and popups
  --use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  'nvim-treesitter/nvim-treesitter',
  -- Additional textobjects for treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  --'hrsh7th/nvim-compe', -- Autocompletion plugin
  --'williamboman/nvim-lsp-installer',
   'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  'ray-x/go.nvim',
  'ray-x/guihua.lua',

 ({
   "hrsh7th/nvim-cmp",
     dependencies= {

   "hrsh7th/cmp-buffer",
   "hrsh7th/cmp-nvim-lsp",
   "hrsh7th/cmp-path",
   "hrsh7th/cmp-nvim-lua",
   "saadparwaiz1/cmp_luasnip",
   }
 }),


  'L3MON4D3/LuaSnip', -- Snippets plugin
  'mattn/emmet-vim',
  'jwalton512/vim-blade',
  'alvan/vim-closetag',
  'nvim-lua/completion-nvim',
  'psliwka/vim-smoothie',
  'terryma/vim-multiple-cursors',
 -- 'SirVer/ultisnips',
--  'honza/vim-snippets',
  'hrsh7th/vim-vsnip',
  'hrsh7th/vim-vsnip-integ',
  --'rstacrus/vim-closer',
 -- 'jiangmiao/auto-pairs',
'windwp/nvim-autopairs',	
 {'akinsho/flutter-tools.nvim', dependencies = 'nvim-lua/plenary.nvim'},
  'Neevash/awesome-flutter-snippets',

 {'nvim-telescope/telescope-fzf-native.nvim', build ='make',cond= vim.fn.executable 'make' ==1},
'fatih/vim-go', 

})

--Incremental live completion
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true
vim.wo.relativenumber =true

--Do not save when switching buffers
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.cmd [[set undofile]]

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.g.onedark_terminal_italics = 2

vim.cmd [[colorscheme torte]]

--Set statusbar
vim.g.lightline = {
  colorscheme = 'powerline',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  component_function = { gitbranch = 'fugitive#head' },
}

--multicursor

vim.g.multi_cursor_use_default_mapping=0

vim.g.multi_cursor_start_word_key = '<C-n>'
vim.g.multi_cursor_select_all_word_key = '<A-n>'
vim.g.multi_cursor_start_key = 'g<C-n>'
vim.g.multi_cursor_select_all_key = 'g<A-n>'
vim.g.multi_cursor_next_key = '<C-n>'
vim.g.multi_cursor_prev_key = '<C-p>'
vim.g.multi_cursor_skip_key = '<C-x>'
vim.g.multi_cursor_quit_key = '<Esc>'


--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

--Map blankline
--vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
--require('gitsigns').setup {
--  signs = {
--    add = { hl = 'GitGutterAdd', text = '+' },
--    change = { hl = 'GitGutterChange', text = '~' },
--    delete = { hl = 'GitGutterDelete', text = '_' },
--    topdelete = { hl = 'GitGutterDelete', text = '‾' },
--    changedelete = { hl = 'GitGutterChange', text = '~' },
--  },
--}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
w  },
}
--Add leader shortcuts
--
pcall(require('telescope').load_extension, 'fzf')

vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })


-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
 vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]



end
local servers = { clangd={} ,
         rust_analyzer={} ,
	 pyright={}, 
	 tsserver={},
	 cssls={},bashls={},
	 html={},
	 jsonls={},
	 intelephense={}
 }
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require("mason").setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup{
	ensure_installed = vim.tbl_keys(servers),
}
--require("mason-lspconfig").setup()
mason_lspconfig.setup_handlers{

	function(server_name)
	require('lspconfig')[server_name].setup{
			capabilities = capabilities,
			on_attach = on_attach, 
			settings = servers[server_name],
	}
 	end,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable the following language servers


for _, lsp in ipairs(servers) do
 nvim_lsp[lsp].setup {
    on_attach = on_attach,
  capabilities = capabilities,
}
end

-- Example custom server
local sumneko_root_path = vim.fn.getenv("HOME").."/.local/bin/sumneko_lua" -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/bin/linux/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


require('lspconfig').tsserver.setup{}


-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Set completeopt to have a better completion experience
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {

	    {
                name = 'nvim_lsp'
            }, 
	    {
                name = 'buffer'
            }, 
	    {
                name = 'luasnip'
            }, 
	    {
                name = 'nvim_lua'
            }, {
                name = 'path'
            }
     },
}

local status_ok, npairs =pcall(require, "nvim-autopairs")
if not status_ok then
	return

end 

npairs.setup {

	check_ts = true, 
	ts_config = {

		lua = { "string", "source"},
		javascript ={ "string", "template_string"},
		java = false,
	},
	disable_filetype = {"TelescopePropt"},
	fast_wrap = {

		map = "<M-e>",
		chars = {"{","[","(",'"',"'"},
		pattern = string.gsub([[%'%"%(%>%]%}%,]],"%s+",""),
		offset =0,
		end_key= "$",
		keys= "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "PmenuSel",
		highlight_grey = "LineNr",

	},

}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok , cmp=pcall(require, "cmp")

if not cmp_status_ok then

	return

end 


cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = {tex = ""}}))

require("flutter-tools").setup{} -- use defaults

