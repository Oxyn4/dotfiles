local load_status, Hydra = pcall(require, "hydra")

if not load_status then
	return
end

Hydra({
	name = "Window resize",
	hint = false,
	config = {
		foriegn_keys = nil,
		exit = false,
		hint = false,
	},
	mode = "n",
	body = "+",
	timeout = 2000,
	heads = {
		{ "<right>", "<Cmd>vertical resize -1<CR>" },
		{ "<left>", "<Cmd>vertical resize +1<CR>" },
		{ "<up>", "<Cmd>resize -1<CR>" },
		{ "<down>", "<Cmd>resize +1<CR>" },
	},
})
