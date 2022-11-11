local lualine_load_status, lualine = pcall(require, "lualine")
local hydra_statusline_load_status, hydra_statusline = pcall(require, "lualine")

if not lualine_load_status and hydra_statusline_load_status then
	return
end

-- Copyright (c) 2020-2021 hoob3rt
-- MIT license, see LICENSE for more details.
local CustomMode = {}

-- stylua: ignore
CustomMode.map = {
    ['n']     = 'NORMAL',
    ['no']    = 'O-PENDING',
    ['nov']   = 'O-PENDING',
    ['noV']   = 'O-PENDING',
    ['no\22'] = 'O-PENDING',
    ['niI']   = 'NORMAL',
    ['niR']   = 'NORMAL',
    ['niV']   = 'NORMAL',
    ['nt']    = 'NORMAL',
    ['ntT']   = 'NORMAL',
    ['v']     = 'VISUAL',
    ['vs']    = 'VISUAL',
    ['V']     = 'V-LINE',
    ['Vs']    = 'V-LINE',
    ['\22']   = 'V-BLOCK',
    ['\22s']  = 'V-BLOCK',
    ['s']     = 'SELECT',
    ['S']     = 'S-LINE',
    ['\19']   = 'S-BLOCK',
    ['i']     = 'INSERT',
    ['ic']    = 'INSERT',
    ['ix']    = 'INSERT',
    ['R']     = 'REPLACE',
    ['Rc']    = 'REPLACE',
    ['Rx']    = 'REPLACE',
    ['Rv']    = 'V-REPLACE',
    ['Rvc']   = 'V-REPLACE',
    ['Rvx']   = 'V-REPLACE',
    ['c']     = 'COMMAND',
    ['cv']    = 'EX',
    ['ce']    = 'EX',
    ['r']     = 'REPLACE',
    ['rm']    = 'MORE',
    ['r?']    = 'CONFIRM',
    ['!']     = 'SHELL',
    ['t']     = 'TERMINAL',
}

---@return string current mode name
function CustomMode.get_mode()
	local mode_code = vim.api.nvim_get_mode().mode
	if CustomMode.map[mode_code] == nil then
		return mode_code
	end
	return CustomMode.map[mode_code]
end

function HydraGetMode()
	if hydra_statusline.is_active() then
		return hydra_statusline.get_name()
	end
	return CustomMode:get_mode()
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
		disabled_filetypes = {
			statusline = { "NvimTree", "aerial" },
			winbar = { "NvimTree", "aerial" },
		},
	},
	sections = {
		lualine_a = { HydraGetMode },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
})
