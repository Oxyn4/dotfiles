local load_status, Hydra = pcall(require, "hydra")

if not load_status then
	return
end

Hydra({
	name = "Tab Mode",
	hint = false,
	config = {
		foriegn_keys = nil,
		exit = false,
		hint = false,
	},
	mode = "n",
	body = "<C-c>",
	timeout = 2000,
	heads = {
		{ "n", "<Cmd>:tabnew | NvimTreeOpen<CR>" },
		{ "<C-v>", "<Cmd>:tabclose<CR>" },
		-- uses plugins vim-bbye Bdelete method - better version of vanilla bdelete
		-- closes current buffer
		{ "c", "<Cmd>:Bdelete<CR>" },
		-- next tab
		{ "<C-right>", "<Cmd>:tabn<CR>" },
		--prev tab
		{ "<C-left>", "<Cmd>:tabp<CR>" },
		--next buffer
		{ "<right>", "<Cmd>:BufferLineCycleNext<CR>" },
		--prev buffer
		{ "<left>", "<Cmd>:BufferLineCyclePrev<CR>" },
	},
})
