local load_status, plugin = pcall(require, "colorizer")

if not load_status then
	return
end

-- Exclude some filetypes from highlighting by using `!`
plugin.setup({
	"*", -- Highlight all files, but customize some others.
})
