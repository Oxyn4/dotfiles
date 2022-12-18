local load_status, plugin = pcall(require, "bufferline")

if not load_status then
	return
end

plugin.setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = true,
		indicator = {
			style = "icon",
		},
		offsets = {
			{
				filetype = "NvimTree",
				text = "File explorer",
				text_align = "center",
				-- https://github.com/akinsho/bufferline.nvim/issues/316
				padding = 1,
				seperator = true,
			},
			{
				filetype = "vim-plug",
				text = "Plugin Manaer",
				text_align = "center",
				-- https://github.com/akinsho/bufferline.nvim/issues/316
				padding = 1,
				seperator = true,
			},
			{
				filetype = "Outline",
				text = "Symbol explorer",
				text_align = "center",
				-- https://github.com/akinsho/bufferline.nvim/issues/316
				padding = 1,
				seperator = true,
			},
		},
		modified_icon = "",
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_default_icon = true,
		separator_style = "thin",
		show_close_icon = false,
		show_buffer_close_icons = false,
		highlights = {
			fill = {
				guibg = "fg",
			},
		},
	},
})
