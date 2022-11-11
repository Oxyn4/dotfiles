local load_status, plugin = pcall(require, "nvim-autopairs")

if not load_status then
	return
end

plugin.setup({
	disable_filetype = {},
})
