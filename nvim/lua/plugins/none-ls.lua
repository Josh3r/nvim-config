return {
	{
		"nvimtools/none-ls-extras.nvim",
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					require("none-ls.code_actions.eslint"),
				}
			})
		end
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					--null_ls.builtins.completion.spell, Note: For text snippets, disabling it to cut-down noise
					null_ls.builtins.formatting.prettier,
					require("none-ls.diagnostics.eslint"),
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
