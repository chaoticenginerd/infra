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
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fs", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.opt.background = "light"
vim.cmd("colorscheme oxocarbon")
