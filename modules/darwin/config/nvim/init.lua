-- Set leader key before lazy.nvim
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- LazyVim options setup
local opt = vim.opt

-- Keep your preferred settings
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = false -- Keep tabs instead of spaces
opt.clipboard = "" -- Don't use system clipboard
opt.scrolloff = 7
opt.sidescrolloff = 7

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with LazyVim
require("lazy").setup({
  spec = {
    -- Import LazyVim and its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    
    -- Your colorscheme
    {
      "sainnhe/gruvbox-material",
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.gruvbox_material_enable_italic = false
        vim.g.gruvbox_material_enable_bold = true
        vim.g.gruvbox_material_foreground = "original"
        vim.cmd.colorscheme("gruvbox-material")
      end,
    },
    
    -- Your git tools
    {
      "SuperBo/fugit2.nvim",
      opts = {
        width = 70,
      },
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
        {
          "chrisgrieser/nvim-tinygit",
          dependencies = { "stevearc/dressing.nvim" },
        },
      },
      cmd = { "Fugit2", "Fugit2Diff", "Fugit2Graph" },
      keys = {
        { "<leader>F", mode = "n", "<cmd>Fugit2<cr>", desc = "Fugit2" },
      },
    },
    
    {
      "sindrets/diffview.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      opts = {},
    },
    
    -- Your undotree configuration
    {
      "jiaoshijie/undotree",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("undotree").setup({
          float_diff = true,
          layout = "left_bottom",
          position = "left",
          ignore_filetype = {
            "undotree",
            "undotreeDiff",
            "qf",
            "TelescopePrompt",
            "spectre_panel",
            "tsplayground",
          },
          window = {
            winblend = 0,
          },
          keymaps = {
            ["j"] = "move_next",
            ["k"] = "move_prev",
            ["gj"] = "move2parent",
            ["J"] = "move_change_next",
            ["K"] = "move_change_prev",
            ["<cr>"] = "action_enter",
            ["p"] = "enter_diffbuf",
            ["<C-c>"] = "quit",
          },
        })
        vim.keymap.set("n", "<C-u>", require("undotree").toggle)
      end,
    },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = { colorscheme = { "gruvbox-material", "tokyonight" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Your custom keymap
vim.keymap.set("n", "gx", [[:silent execute '!open ' . shellescape(expand('<cfile>'), 1)<CR>]], { silent = true })
