vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use
	{
		-- Packer manages itself
		{ 'wbthomason/packer.nvim' },

		-- Faster loading
		{ 'nathom/filetype.nvim' },
		{ 'lewis6991/impatient.nvim' },

		-- Colorscheme
		{ 'navarasu/onedark.nvim' },

		-- Status line
		{ 'nvim-lualine/lualine.nvim' },

		-- Language server installer
		{ 'williamboman/nvim-lsp-installer' },

		-- Config for language servers
		{
			'neovim/nvim-lspconfig',
			after = 'nvim-lsp-installer',
		},

		-- Complete engine
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/nvim-cmp' },

		-- Most recently used
		{ 'yegappan/mru' },
		{ 'mhinz/vim-startify'},
	}
end)
