local load_status, Hydra = pcall(require, "hydra")

if not load_status then
	return
end

local cmd = require("hydra.keymap-util").cmd

Hydra({
	name = "Telescope",
	hint = false,
	config = {
		foriegn_keys = nil,
		exit = true,
		hint = false,
	},
	mode = "n",
	body = "<leader>f",
	timeout = 2000,
	heads = {
		-- file search in users home directory
		{ "f", cmd("Telescope find_files hidden=true no_ignore=true cwd=" .. os.getenv("HOME")) },
		-- files search entire computer
		{ "<C-f>", cmd("Telescope find_files hidden=true no_ignore=true") },
		-- grep strings in files only in home directory
		{ "g", cmd("Telescope live_grep cwd=" .. os.getenv("HOME")) },
		-- grep strings in files over the entire system
		{ "<C-g>", cmd("Telescope live_grep") },
		-- search current buffer
		{ "c", cmd("Telescope current_buffer_fuzzy_find") },
		-- search lsp references of variables
		{ "r", cmd("Telescope lsp_references") },
		-- search diagnostic error messages
		{ "d", cmd("Telescope diagnostics") },
		-- search tree sitter tags
		{ "t", cmd("Telescope treesitter") },
		-- search man pages
		{ "m", cmd("Telescope man_pages") },
		-- search projects
		{ "p", cmd("Telescope project") },
	},
})
