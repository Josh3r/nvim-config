
return {
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- or 'nvim-tree/nvim-web-devicons'
		opts = {},
		config = function()
			require('render-markdown').setup({
				enabled = true, -- Render by default
				render_modes = { 'n', 'c', 't' }, -- Modes where rendering is active (Normal, Command, Terminal)
				anti_conceal = {
					enabled = true, -- Temporarily reveals raw syntax on the current cursor line
				},
				heading = {
					sign = false,
					icons = { '   ', '   ', '   ', '   ', '   ', '   ' },
				},
				code = {
					width = 'block', -- Extends the background highlight to the full block width
					right_pad = 4,
				},
			})

			-- Optional: Map a key to toggle the rendered view
			vim.keymap.set('n', '<leader>tm', '<cmd>RenderMarkdown toggle<cr>', { desc = 'Toggle Markdown Render' })

		end
	}
}
