-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set('n', '<leader>ff', function()
  require('fzf-lua').files()
end, { desc = 'Find files (fzf-lua)' })

-- Toggle Neo-tree with Ctrl+t
vim.keymap.set('n', '<C-t>', function()
  require('neo-tree.command').execute({ toggle = true, reveal = true })
end, { desc = 'Toggle Neo-tree' })

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,     -- Show inline
  signs = false,          -- Disable gutter signs
  underline = true,       -- Underline problematic text
  update_in_insert = false,
  severity_sort = true,
})

-- LSP keybinds
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gR', vim.lsp.buf.references, { desc = 'Find references' })
vim.keymap.set('n', 'g?', vim.diagnostic.open_float, { desc = 'Show diagnostics' })
vim.keymap.set('n', 'gq', vim.diagnostic.setloclist, { desc = 'Show all diagnostics' })
vim.keymap.set('n', '<D-.>', vim.lsp.buf.code_action, { desc = 'LSP code actions' })

-- Live grep (fzf-lua)
vim.keymap.set('n', '<leader>fg', function()
  require('fzf-lua').live_grep()
end, { desc = 'Live grep (fzf-lua)' })
