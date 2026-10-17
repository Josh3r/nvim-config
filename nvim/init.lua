vim.cmd("set relativenumber")
require("config.lazy")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>t", ":Neotree filesystem left<CR>", {})
vim.cmd("set clipboard=unnamedplus")
vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
-- Code block for dealing with hard-to-see relative lines
local function set_line_nr_hl()
  vim.api.nvim_set_hl(0, "LineNr",      { fg = "#8b95b8" })               -- fallback / all lines
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#8b95b8" })               -- relative lines above
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#8b95b8" })               -- relative lines below
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffc777", bold = true }) -- current line
end

set_line_nr_hl()

-- Re-apply whenever the colorscheme changes, otherwise it overrides you
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_line_nr_hl })
-- end block
-- For ensuring MD pop-up doesn't run off screen
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ max_width = 80 })
end, { desc = "LSP hover" })
-- Make popup standout from BG
vim.o.winborder = "rounded"
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1b26" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#8b95b8", bg = "#1a1b26" })
-- end

-- syntax concealment for inline markdown rendering
vim.opt.conceallevel = 2
