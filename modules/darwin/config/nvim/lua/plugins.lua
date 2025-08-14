return {
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true},
  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
  },

  { 'echasnovski/mini.ai', version = '*', opts = {} },
  { 'echasnovski/mini.comment', version = '*', opts = { } },
  { 'echasnovski/mini.jump', version = '*', opts = { } },
  { 'echasnovski/mini.pairs', version = '*', opts = { } },
  { 'echasnovski/mini.statusline', version = '*', opts = { useIcons = false} },
  { 'echasnovski/mini.surround', version = '*', opts = {} }, 
  { 'echasnovski/mini.splitjoin', version = '*', opts = {} },
  { 'echasnovski/mini.trailspace', version = '*', opts = {} },
}

