-- =========================================
--  NeoVim 0.12+ Native Pack + LSP Config, optimize  with load 155ms
-- =========================================

-- Bootstrap plugins (native pack)
vim.pack.add({
    { src = "https://github.com/williamboman/mason.nvim.git" },
    { src = "https://github.com/williamboman/mason-lspconfig.nvim.git" }, -- Γ£à Added
    { src = "https://github.com/neovim/nvim-lspconfig.git" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git",  build = ":TSUpdate" },
    { src = "https://github.com/hrsh7th/nvim-cmp.git" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp.git" },
    { src = "https://github.com/hrsh7th/cmp-buffer.git" },
    { src = "https://github.com/L3MON4D3/LuaSnip.git" },
    { src = "https://github.com/echasnovski/mini.pairs.git" },
    { src = "https://github.com/echasnovski/mini.icons.git" },
    { src = "https://github.com/nvim-lualine/lualine.nvim.git" },
    { src = "https://github.com/ibhagwan/fzf-lua.git" },
    { src = "https://github.com/folke/tokyonight.nvim.git" },
    { src = "https://github.com/akinsho/toggleterm.nvim.git" },
    -- Γ¥î Removed nvim-web-devicons (using mini.icons instead)
})

-- =========================================
--  Mason setup
-- =========================================
require("mason").setup()
require("mason-lspconfig").setup({
    -- ensure_installed = { "lua_ls", "html", "intelephense", "ts_ls", "gopls", "pyright" },

})

-- =========================================
--  Autocompletion (nvim-cmp) ΓÇö must come BEFORE LSP config
-- =========================================
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load() -- optional: load VS Code snippets

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- Γ£à Added
        { name = "buffer" },
    },
    experimental = { ghost_text = true },
})

-- =========================================
--  LSP (New Native API)
-- =========================================
local lsp = vim.lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities() -- Γ£à Now safe to call

local servers = { "lua_ls", "html", "intelephense", "ts_ls", "gopls", "pyright" }

for _, server in ipairs(servers) do
    lsp.config(server, {
        capabilities = capabilities,
        settings = {},
    })
    lsp.enable(server)
end

-- Optional: enhance lua_ls
lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
        },
    },
})

-- =========================================
--  Treesitter (Syntax Highlight)
-- =========================================
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "php", "blade", "html", "javascript", "json", "go" },
    highlight = { enable = true },
})

-- =========================================
--  UI & Aesthetic
-- =========================================
vim.cmd.colorscheme("tokyonight")

-- Γ£à Mock nvim-web-devicons for compatibility
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("lualine").setup({
    options = { theme = "tokyonight" },
})

require("mini.pairs").setup()
require("toggleterm").setup({
    size = 15,
    open_mapping = [[<c-\>]],
    shade_terminals = true,
    shading_factor = 2,
    direction = "float",
    float_opts = { border = "curved", winblend = 0 },
})

-- Helper: Toggle lazygit (if installed)
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
function _lazygit_toggle()
    lazygit:toggle()
end

-- =========================================
--  Display Settings
-- =========================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- =========================================
--  Clipboard Integration (WSL)
-- =========================================
--if vim.fn.has("wsl") == 1 then
--  vim.api.nvim_create_autocmd("TextYankPost", {
--      callback = function()
--          vim.fn.system("clip.exe", vim.fn.getreg('"'))
--      end,
--  })
--  vim.opt.clipboard = "unnamedplus"
--end


-- =========================================
--  Clipboard Integration (WSL - Lazy load)
-- =========================================
if vim.fn.has("wsl") == 1 then
    -- Simple manual yank -> clip.exe
    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
            vim.fn.system("clip.exe", vim.fn.getreg('"'))
        end,
    })

    -- Defer clipboard provider to load after UI ready (for speed)
    vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
            vim.defer_fn(function()
                vim.opt.clipboard = "unnamedplus"
            end, 300) -- delay 300ms after startup
        end,
    })
end
-- =========================================
--  Diagnostics / Auto Lint + Format
-- =========================================
vim.diagnostic.config({
    virtual_text = { prefix = "ΓùÅ" },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Auto format before save
local lsp_format_group = vim.api.nvim_create_augroup("LspAutoFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = lsp_format_group,
    callback = function(event)
        local client = vim.lsp.get_clients({ bufnr = event.buf })[1]
        if client and client.supports_method("textDocument/formatting") then
            vim.lsp.buf.format({ async = false })
        end
    end,
})

-- =========================================
--  Keymaps
-- =========================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- FZF
keymap("n", "<leader>ff", function() require("fzf-lua").files() end, opts)
keymap("n", "<leader>fg", function() require("fzf-lua").live_grep() end, opts)
keymap("n", "<leader>fb", function() require("fzf-lua").buffers() end, opts)
keymap("n", "<leader>fh", function() require("fzf-lua").help_tags() end, opts)

-- Format & Diagnostics
keymap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
keymap("n", "<leader>ld", vim.diagnostic.open_float, opts)
keymap("n", "<leader>ln", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>lp", vim.diagnostic.goto_prev, opts)

-- Quick actions
keymap("n", "<leader>w", "<cmd>w<CR>", opts)
keymap("n", "<leader>q", "<cmd>q<CR>", opts)
keymap("n", "<leader>ft", "<cmd>ToggleTerm<CR>", opts)
keymap("n", "<leader>fu", "<cmd>lua _lazygit_toggle()<CR>", opts)
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)

-- Buffer navigation
keymap("n", "<leader>bb", "<cmd>bnext<CR>", opts)
keymap("n", "<leader>bp", "<cmd>bprevious<CR>", opts)
keymap("n", "<leader>bd", "<cmd>bd<CR>", opts)

-- =========================================
--  Memory Watcher
-- =========================================
local api = vim.api
local timer = vim.loop.new_timer()
local win, buf
local last = 0

local function create_win()
    buf = api.nvim_create_buf(false, true)
    local opts = {
        relative = "editor",
        width = 25,
        height = 3,
        row = 1,
        col = vim.o.columns - 28,
        style = "minimal",
        border = "rounded",
    }
    win = api.nvim_open_win(buf, false, opts)
end

local function update_mem()
    local current = vim.loop.resident_set_memory() / (1024 * 1024)
    local diff = current - last
    local sign = diff >= 0 and "+" or "-"
    local text = {
        string.format("Mem: %.2f MB", current),
        string.format("Change: %s%.2f MB", sign, math.abs(diff)),
    }
    api.nvim_buf_set_lines(buf, 0, -1, false, text)
    last = current
end

vim.api.nvim_create_user_command("MemWatch", function()
    if win and api.nvim_win_is_valid(win) then
        print("Memory watcher already running")
        return
    end
    create_win()
    timer:start(0, 2000, vim.schedule_wrap(update_mem))
    print("MemoryWarning Memory watcher started")
end, {})

vim.api.nvim_create_user_command("MemWatchStop", function()
    timer:stop()
    timer:close()
    if win and api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
    end
    print("MemoryWarning Memory watcher stopped")
end, {})

-- Auto-stop memory watcher on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        pcall(vim.cmd.MemWatchStop)
    end,
})

-- =========================================
--  Plugin Update Helper
-- =========================================
vim.api.nvim_create_user_command("PackUpdate", function()
    print("≡ƒöä Updating plugins...")
    vim.pack.update()
    print("Γ£à Plugins updated!")
end, { desc = "Update all plugins (vim.pack)" })

keymap("n", "<leader>pu", "<cmd>PackUpdate<CR>", { noremap = true, silent = true })
