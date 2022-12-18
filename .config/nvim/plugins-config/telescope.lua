local telescope_load_status, telescope  = pcall(require, "telescope")
local telescope_actions_load_status, telescope_actions = pcall(require, "telescope.actions")

if not telescope_load_status and telescope_actions_load_status then
	return
end

telescope.setup{
  defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key",
                ["<esc>"] = telescope_actions.close,

            }
        }
    },
    pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- 
        -- }
        project = {
            hidden_files = true, -- default: false
            order_by = "recent",
            sync_with_nvim_tree = true, -- default false
        },

        -- please take a look at the readme of the extension you want to configure
    }
}

-- require'telescope'.extensions.project.project{}
telescope.load_extension('project')
--local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
