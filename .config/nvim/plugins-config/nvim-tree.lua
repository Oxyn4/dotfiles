vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 1

require("nvim-tree").setup({
    sort_by = "case_sensitive",
        view = {
            adaptive_size = false,
            width=30,
            mappings = {
                list = {
                    { key = "u", action = "dir_up" },
                    { key = "t", action = "tabnew" },
                    { key = "s", action = "vsplit" },
                    { key = "<C-s>", action = "split" },
                    { key = "e", action = "cd" },
                },
            },
        },

    renderer = {
        group_empty = true,
        indent_markers = {
            enable=true,
            inline_arrows=true,
            icons= {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
           webdev_colors = true,
            git_placement = "after",
            padding = " ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs={
                default = "",
                symlink = "",
                bookmark = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "",
                    untracked = "★",
                    deleted = "",
                },
            },
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        debounce_delay = 50,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },

    open_on_tab = true,
    hijack_netrw = true,


    filters = {
        dotfiles = false,
    },
})

vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
            vim.cmd "quit"
        end
    end
})

