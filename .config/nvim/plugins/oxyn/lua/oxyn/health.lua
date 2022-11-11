-- check oxyn configuration help
local M = {}

function IsExecutable(name)
	if vim.api.nvim_exec('echo executable("' .. name .. '")', true) == "1" then
		return true
	end
	return false
end

function WhereExecutable(name)
	return vim.api.nvim_exec('echo exepath("' .. name .. '")', true)
end

function HealthCheckExecutable(execname, command)
	if IsExecutable(command) then
		vim.health.report_ok(execname .. " installed: " .. WhereExecutable(command))
	else
		vim.health.report_error("missing " .. execname .. "")
	end
end

function M.check()
	vim.health.report_start("Oxyn configuration report")

	vim.health.report_start("Telescope dependancies")

	HealthCheckExecutable("ripgrep", "rg")

	vim.health.report_start("LSP servers")

	HealthCheckExecutable("clangd", "clangd")

	vim.health.report_start("Formatters")

	HealthCheckExecutable("clang format", "clang-format")
	HealthCheckExecutable("stylua", "stylua")
end

return M
