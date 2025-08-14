-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Keep your preferred leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Keep some of your preferred settings
local opt = vim.opt

-- Indentation (keep your preference for tabs)
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = false -- Keep tabs instead of spaces

-- Clipboard (keep your preference to not use system clipboard)
opt.clipboard = ""

-- Keep your scroll offset preferences
opt.scrolloff = 7
opt.sidescrolloff = 7
