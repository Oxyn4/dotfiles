local notify_load_status, notify = pcall(require, "notify")

if not notify_load_status then
	return
end

notify.setup({
	background_colour = "#000000",
	stages = "fade",
	timeout = 5000,
	max_width = 50,
	max_height = 20,
})

vim.notify = notify
