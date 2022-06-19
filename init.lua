-- Plugins
require('plugins')

-- Keybinds
require('binds')

-- Impatient
require('impatient')

-- Colorscheme
local onedark = require('onedark')
onedark.setup {
	code_style = {
		comments = 'none'
	},
	highlights = {
		VertSplit = { bg = '#3b3f4c' },
	},
}
onedark.load()

-- Status line
require('lualine').setup {
	options = {
		theme = 'onedark',
		icons_enabled = false,
		section_separators = { left = '', right = ' ' },
		component_separators = '',
	},
	sections = {
		lualine_a = {
			{ 'mode', fmt = function(str) return str:sub(1,1) end }
		},
		lualine_x = { 'encoding', 'filetype' },
		lualine_y = {},
	},
}

-- Language server
require('nvim-lsp-installer').setup({
	automatic_installation = true,
})
local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
		},
	},
})
lspconfig.clangd.setup {}

-- Tab settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Line number
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- Enable mouse
vim.opt.mouse = 'a'

-- Generic
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.showmode = false
vim.opt.scrolloff = 8
