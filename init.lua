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
		lualine_b = { 'branch' },
		lualine_x = { 'encoding', 'filetype' },
		lualine_y = {},
	},
}

-- Language server
require('nvim-lsp-installer').setup({
	automatic_installation = true,
})

local cmp = require('cmp')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})

cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' },
	}, {
		{ name = 'buffer' },
	})
})

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Setup lspconfig
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['sumneko_lua'].setup {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
		},
	}
}
require('lspconfig')['clangd'].setup {
	capabilities = capabilities
}

vim.g.startify_custom_header = {
	'		███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
	'		████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
	'		██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
	'		██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
	'		██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
	'		╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
}

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

