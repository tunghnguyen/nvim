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
	snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
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
local lspconfig = require('lspconfig')
lspconfig['sumneko_lua'].setup {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
		},
	}
}
lspconfig['clangd'].setup {
	capabilities = capabilities
}
lspconfig['rust_analyzer'].setup {
	capabilities = capabilities
}

-- Startup screen
local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
	return
end
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.opts.hl = '#abb2bf'
local banner = {
	[[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
	[[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
	[[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
	[[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
	[[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
	[[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
}
dashboard.section.header.val = banner
dashboard.section.buttons.val = {
	dashboard.button('<Leader> e n', '  New File', ':ene <BAR> startinsert <CR>'),
	dashboard.button('<Leader> f r', '  Recent Files', ':Telescope oldfiles <CR>'),
	dashboard.button('<Leader> f p', '  Find Project', ':Telescope project <CR>'),
	dashboard.button('<Leader> e v', '  Configuration', ':e $MYVIMRC <CR>'),
	dashboard.button('<Leader>   u', '  Update Plugins', ':PackerUpdate <CR>'),
	dashboard.button('<Leader>   q', '  Quit Neovim', ':qa<CR>'),
}
local function footer()
	local version = vim.version()
	local print_version = 'v' .. version.major .. '.' .. version.minor .. '.' .. version.patch

	return print_version
end
dashboard.section.footer.val = footer()
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)

-- Telescope
local telescope = require('telescope')
telescope.load_extension('project')
telescope.setup {
	extensions = {
		project = {
			hidden_files = false,
		}
	}
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
