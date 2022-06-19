-- Mapleader
vim.keymap.set('n', '<Space>', '<Nop>')
vim.g.mapleader = ' '

-- Navigate with ctrl-[hjkl]
vim.keymap.set('n', '<C-h>', ":wincmd h<CR>", {silent = true})
vim.keymap.set('n', '<C-j>', ":wincmd j<CR>", {silent = true})
vim.keymap.set('n', '<C-k>', ":wincmd k<CR>", {silent = true})
vim.keymap.set('n', '<C-l>', ":wincmd l<CR>", {silent = true})
vim.keymap.set('i', '<C-j>', '<C-N>')
vim.keymap.set('i', '<C-k>', '<C-P>')

-- Move text with alt-[jk]
vim.keymap.set('n', '<A-j>', ":m .+1<CR>==", {silent = true})
vim.keymap.set('n', '<A-k>', ":m .-2<CR>==", {silent = true})
vim.keymap.set('i', '<A-j>', "<Esc>:m .+1<CR>==gi", {silent = true})
vim.keymap.set('i', '<A-k>', "<Esc>:m .-2<CR>==gi", {silent = true})
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", {silent = true})
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", {silent = true})

-- Diagnostics
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)

-- Language servers
local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<Leader>wl', function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<Leader>f', vim.lsp.buf.formatting, bufopts)
