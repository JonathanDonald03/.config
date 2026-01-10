return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
                layout_strategy = "vertical",
                layout_config = {
                    vertical = {
                        prompt_position = "bottom", -- prompt at the bottom
                        mirror = false,             -- results above prompt
                        width = 0.9,                -- take up most of the screen
                        height = 0.9,
                    },
                },
                sorting_strategy = "descending", -- results below the prompt
            }
        })

        local builtin = require('telescope.builtin')

        -- Keymaps
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}

