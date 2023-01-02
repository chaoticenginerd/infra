-- Settings
   -- Editor UI
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "88"
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.mouse = ""
vim.opt.termguicolors = true

   -- Editing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars:append { trail = "*" }
vim.opt.completeopt = { "menuone", "noinsert" }

   -- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3

   -- Leader
vim.g.mapleader = " "

-- Plugins
require("packer").startup(function(use)
    use { "wbthomason/packer.nvim" }
    use {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { {"nvim-lua/plenary.nvim"} }
    }
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    }
    use {"nyoom-engineering/oxocarbon.nvim"}
    use {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
end)

   -- Treesitter
require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "help", "lua", "python", "rust" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
-- LSP
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local nvim_lsp = require("lspconfig")
local servers = {
    "pyright",
    "rust_analyzer",
    "sumneko_lua",
}

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = servers,
}

for _, server in ipairs(servers) do
    nvim_lsp[server].setup {
        on_attach = on_attach,
    }
end

-- Keymaps
   -- General
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>q<cr>")
vim.keymap.set("n", "<leader><cr>", "<cmd>source %<cr>")

   -- Splits
vim.keymap.set("n", "<leader>v", "<cmd>wincmd v<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>wincmd s<cr>")

   -- Splits navigation
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<cr>")
vim.keymap.set("n", "<leader>j", "<cmd>wincmd j<cr>")
vim.keymap.set("n", "<leader>k", "<cmd>wincmd k<cr>")
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<cr>")

   -- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>tf", builtin.find_files, {})
vim.keymap.set("n", "<leader>tb", builtin.buffers, {})
vim.keymap.set("n", "<leader>ts", builtin.live_grep, {})
vim.keymap.set("n", "<leader>th", builtin.help_tags, {})

vim.opt.background = "light"
vim.cmd("colorscheme oxocarbon")
