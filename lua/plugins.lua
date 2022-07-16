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
--		{ 'nvim-lualine/lualine.nvim' },

		-- Config for language servers
		{ 'williamboman/nvim-lsp-installer' },

		{ 'neovim/nvim-lspconfig' },

		-- Complete engine
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/nvim-cmp' },

		-- Startup screen
		{ 'goolord/alpha-nvim' },

		-- Telescopt
		{
			'nvim-telescope/telescope.nvim',
			requires = {
				{ 'nvim-lua/plenary.nvim' },
				{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
			}
		},
		{ 'nvim-telescope/telescope-project.nvim' },

		-- Snippet
		{ 'L3MON4D3/LuaSnip' },

		-- Syntax highlighting
		{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
	}
end)
