-- Plugins
require('plugins')

-- Keybinds
require('binds')

-- Impatient
require('impatient')

-- Colorscheme
local onedark = require('onedark')
onedark.setup {
	transparent = true,
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
local on_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
	vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')
lspconfig['sumneko_lua'].setup {
	on_attach = on_attach,
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
	on_attach = on_attach,
	capabilities = capabilities
}
lspconfig['rust_analyzer'].setup {
	on_attach = on_attach,
	capabilities = capabilities
}

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

vim.cmd [[
  highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
  highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
  highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
  highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]

-- Syntax highlighting
require('nvim-treesitter.configs').setup {
	ensure_installed = { "c", "cpp", "lua", "rust" },
	sync_install = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	}
}

-- Startup screen
local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
	return
end
local dashboard = require('alpha.themes.dashboard')
dashboard.section.header.opts.hl = 'abb2bf'
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
