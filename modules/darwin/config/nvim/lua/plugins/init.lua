return {
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = { documentation = { auto_show = false } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			-- Add your LSP servers here with the blink.cmp capabilities
			-- Example: lspconfig.lua_ls.setup({ capabilities = capabilities })
		end,
	},
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

	{ "echasnovski/mini.ai", version = "*", opts = {} },
	{ "echasnovski/mini.comment", version = "*", opts = {} },
	{ "echasnovski/mini.jump", version = "*", opts = {} },
	{ "echasnovski/mini.pairs", version = "*", opts = {} },
	{ "echasnovski/mini.git", version = "*", opts = {} },
	{
		"echasnovski/mini.statusline",
		version = "*",
		opts = {
			use_icons = false,
			content = {
				active = function()
					local mode, mode_hl = require("mini.statusline").section_mode({ trunc_width = 120 })
					local git = require("mini.statusline").section_git({ trunc_width = 40 })
					local diff = require("mini.statusline").section_diff({ trunc_width = 75 })
					local diagnostics = require("mini.statusline").section_diagnostics({ trunc_width = 75 })
					local filename = require("mini.statusline").section_filename({ trunc_width = 140 })
					local location = require("mini.statusline").section_location({ trunc_width = 75 })
					local search = require("mini.statusline").section_searchcount({ trunc_width = 75 })

					return require("mini.statusline").combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
						"%<",
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=",
						{ hl = mode_hl, strings = { search, location } },
					})
				end,
			},
		},
	},
	{ "echasnovski/mini.surround", version = "*", opts = {} },
	{ "echasnovski/mini.splitjoin", version = "*", opts = {} },
	{ "echasnovski/mini.trailspace", version = "*", opts = {} },
	{ "echasnovski/mini.icons", version = "*", opts = {} },

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"javascript",
					"typescript",
					"svelte",
					"html",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				fold = { enable = true },
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				yaml = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
			},

			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
		},
	},

	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			require("fzf-lua").setup({
				actions = {
					fzf = {
						["ctrl-q"] = { fn = require("fzf-lua").actions.file_sel_to_qf, prefix = "select-all" },
					},
				},
			})
		end,
	},
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = { { "mason-org/mason.nvim", opts = {} }, "neovim/nvim-lspconfig" },
	},
	{ "sindrets/diffview.nvim", opts = {} },
}
