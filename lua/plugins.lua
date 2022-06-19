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

	}
end)
