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
			capabilities.textDocument.definition = { dynamicRegistration = true, linkSupport = true }
			capabilities.textDocument.references = { dynamicRegistration = true }

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = {
								"vim",
								"require",
							},
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			vim.lsp.enable("lua_ls")

			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "tsx", "jsx" },
			})
			vim.lsp.enable("ts_ls")

			-- Use project-local svelteserver instead of Mason's, because Mason's
			-- bundled TypeScript 5.9.3 has a stack overflow bug in findSourceFileWorker
			-- when processing monorepos with many project references.
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "svelte",
				callback = function(args)
					local root = vim.fs.root(args.buf, { "svelte.config.js", "svelte.config.ts" })
					if not root then
						return
					end

					-- Find project-local svelteserver by traversing up from root
					local cmd = { "svelteserver", "--stdio" }
					local dir = root
					while dir and dir ~= "/" do
						local candidate = dir .. "/node_modules/.bin/svelteserver"
						if vim.uv.fs_stat(candidate) then
							cmd = { candidate, "--stdio" }
							break
						end
						dir = vim.fn.fnamemodify(dir, ":h")
					end

					vim.lsp.start({
						name = "svelte",
						cmd = cmd,
						root_dir = root,
						capabilities = capabilities,
					})
				end,
			})
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
	{ "echasnovski/mini.diff", version = "*", opts = {} },
	{
		"echasnovski/mini.statusline",
		version = "*",
		opts = {
			use_icons = false,
			content = {
				active = function()
					local mode, mode_hl = require("mini.statusline").section_mode({ trunc_width = 120 })
					local diagnostics = require("mini.statusline").section_diagnostics({ trunc_width = 75 })
					local filename = require("mini.statusline").section_filename({ trunc_width = 140 })
					local location = require("mini.statusline").section_location({ trunc_width = 75 })
					local search = require("mini.statusline").section_searchcount({ trunc_width = 75 })

					return require("mini.statusline").combine_groups({
						{ hl = mode_hl, strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
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
		"lewis6991/gitsigns.nvim",
		opts = {},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = function(bufnr)
					if vim.api.nvim_buf_get_name(bufnr):match("%.svelte%.ts$") then
						return { "prettier" }
					end

					return { "biome" }
				end,
				typescriptreact = { "biome" },
				json = { "prettier" },
				markdown = { "prettier" },
				yaml = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				html = { "prettier" },
			},

			format_on_save = {
				lsp_format = "never",
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
	{
		"sourcegraph/amp.nvim",
		branch = "main",
		lazy = false,
		opts = { auto_start = true, log_level = "info" },
	},
	{ "sindrets/diffview.nvim" },
	{
		"nicolasgb/jj.nvim",
		version = "*",
		config = function()
			require("jj").setup({})
		end,
		keys = {
			{
				"<leader>jl",
				function()
					require("jj.cmd").log()
				end,
				desc = "jj log",
			},
			{
				"<leader>js",
				function()
					require("jj.cmd").status()
				end,
				desc = "jj status",
			},
			{
				"<leader>jd",
				function()
					require("jj.cmd").describe()
				end,
				desc = "jj describe",
			},
			{
				"<leader>jn",
				function()
					require("jj.cmd").new()
				end,
				desc = "jj new",
			},
			{
				"<leader>jf",
				function()
					require("jj.cmd").fetch()
				end,
				desc = "jj fetch",
			},
			{
				"<leader>jp",
				function()
					require("jj.cmd").push()
				end,
				desc = "jj push",
			},
			{
				"<leader>ju",
				function()
					require("jj.cmd").undo()
				end,
				desc = "jj undo",
			},
			{
				"<leader>jr",
				function()
					require("jj.cmd").redo()
				end,
				desc = "jj redo",
			},
			{
				"<leader>ja",
				function()
					require("jj.annotate").annotate()
				end,
				desc = "jj annotate file",
			},
			{
				"<leader>jA",
				function()
					require("jj.annotate").annotate_line()
				end,
				desc = "jj annotate line",
			},
			{
				"<leader>jD",
				function()
					require("jj.diff").vertical()
				end,
				desc = "jj diff vertical",
			},
		},
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			workspaces = {
				{
					name = "notes",
					path = "~/notes",
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			mode = "topline",
			max_lines = 3,
		},
	},
}
