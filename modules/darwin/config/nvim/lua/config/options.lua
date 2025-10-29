-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.number = true
vim.cmd("colorscheme gruvbox")
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.softtabstop = 3
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.scrolloff = 8

-- Case-insensitive search by default
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable treesitter-based folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- Start with all folds open
vim.opt.foldlevelstart = 99
