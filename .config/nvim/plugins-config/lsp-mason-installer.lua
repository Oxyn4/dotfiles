local mason_load_status, mason = pcall(require, "mason")
local mason_lspconfig_load_status, mason_lspconfig = pcall(require, "mason-lspconfig")

if not mason_load_status and mason_lspconfig_load_status then
	return
end

mason.setup({
	max_concurrent_installers = 4,
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lspconfig.setup({
	ensure_installed = { "sumneko_lua", "rust_analyzer", "clangd", "vimls", "sumneko_lua", "texlab" },
})
