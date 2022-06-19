local opts = { noremap=true, silent=true }

-- Mapleader
vim.keymap.set('n', '<Space>', '<Nop>')
vim.g.mapleader = ' '

-- Navigate with ctrl-[hjkl]
vim.keymap.set('n', '<C-h>', ":wincmd h<CR>", opts)
vim.keymap.set('n', '<C-j>', ":wincmd j<CR>", opts)
vim.keymap.set('n', '<C-k>', ":wincmd k<CR>", opts)
vim.keymap.set('n', '<C-l>', ":wincmd l<CR>", opts)

-- Move text with alt-[jk]
vim.keymap.set('n', '<A-j>', ":m .+1<CR>==", opts)
vim.keymap.set('n', '<A-k>', ":m .-2<CR>==", opts)
vim.keymap.set('i', '<A-j>', "<Esc>:m .+1<CR>==gi", opts)
vim.keymap.set('i', '<A-k>', "<Esc>:m .-2<CR>==gi", opts)
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Diagnostics
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)

-- Language servers
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, opts)
vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
vim.keymap.set('n', '<Leader>wl', function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, opts)
