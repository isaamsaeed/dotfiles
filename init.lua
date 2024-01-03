vim.opt.number = true
vim.opt.relativenumber = true

-- File behaviour
vim.opt.hidden = true
vim.opt.autoread = true

-- Search behaviour
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Tab behaviour
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- Plugins
-- Using vimplug to manage plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.4' })
Plug('tpope/vim-vinegar')
Plug('tpope/vim-commentary')
Plug('tpope/vim-surround')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('folke/tokyonight.nvim')
Plug('stevearc/conform.nvim')
vim.call('plug#end')

-- Setup colour scheme
vim.cmd[[colorscheme tokyonight-storm]]

-- Setup plugins
require('telescope').setup({})
require('nvim-treesitter.configs').setup({
	ensure_installed = { 'javascript', 'typescript' }
})

require('mason').setup({
	ensure_installed = { 'prettier' }
})
require('mason-lspconfig').setup({
	ensure_installed = { 'tsserver', 'eslint' }
})

local lspconfig = require('lspconfig')
lspconfig.tsserver.setup({})
lspconfig.eslint.setup({})

require("conform").setup({
	formatters_by_ft = {
		-- Use a sub-list to run only the first available formatter
		["javascript"] = { "prettier" },
		["javascriptreact"] = { "prettier" },
		["typescript"] = { "prettier" },
		["typescriptreact"] = { "prettier" },
	},
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- Key mappings
-- Leader
vim.keymap.set('n', '<SPACE>', '<Nop>', { noremap = true })
vim.g.mapleader = ' '
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader>z', '<cmd>write<cr>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})

-- LSP
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
