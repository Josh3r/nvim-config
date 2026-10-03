return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {"lua_ls", "ts_ls"},
				automatic_enable = false
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("js_ls")
			vim.lsp.config('ts_ls', {capabilities = capabilities})

			vim.lsp.config('lua_ls', {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath('config')
							and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							version = 'LuaJIT',
							path = {
								'lua/?.lua',
								'lua/?/init.lua',
							},
						},
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
							}
						}
					})
				end,
				settings = {
					Lua = {
						-- ⭐⭐ ADD THIS DIAGNOSTICS SECTION ⭐⭐
						diagnostics = {
							enable = true,
							globals = { "vim" },  
							severity = {
								["undefined-global"] = "Error",  -- Make undefined vars show as errors
								["unused-local"] = "Hint",       -- Make unused vars less intrusive
								["type-check"] = "Warning",
							},
							neededFileStatus = {
								["ambiguity-1"] = "Any",
								["await-in-sync"] = "Any",
								["cast-local-type"] = "Any",
								["circle-doc-class"] = "Any",
								["close-non-object"] = "Any",
							},
						},
						codeLens = {
							enable = true
						},
						hint = {
							enable = true,
							semicolon = "Disable"
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
				capabilities = capabilities
			})

			vim.diagnostic.config({ virtual_text = true})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})
		end
	},
}
