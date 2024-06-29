vim.keymap.set("n", "<leader>fb", "<Cmd>:Telescope file_browser path=%:p:h<CR>", { desc = "Browse Files" })
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").git_files, { desc = "Find Files" })

vim.keymap.set("n", "<leader>fs",
    function()
        vim.lsp.buf.format()
        vim.cmd.update()
    end,
    { desc = "[s]ave" }
)
vim.keymap.set("n", "<leader>fS",
    function()
        local fb = require("telescope").extensions.file_browser
        local fb_actions = require("telescope").extensions.file_browser.actions
        local actions = require "telescope.actions"
        local action_state = require "telescope.actions.state"
        local action_set = require "telescope.actions.set"

        local file_created = false
        fb.file_browser({
            attach_mappings = function(prompt_bufnr, _)
                fb_actions.create_from_prompt:enhance({
                    pre = function()
                        file_created = true
                    end
                })
                action_set.edit:replace(function(_, _)
                    actions.close(prompt_bufnr)

                    local entry = action_state.get_selected_entry()
                    if not entry or not entry.path then
                        return
                    end

                    vim.lsp.buf.format()
                    if file_created then
                        vim.cmd.saveas { entry.path, bang = true }
                        return
                    end

                    vim.ui.select({ "Yes", "No" }, {
                        prompt = "File " .. entry.path .. " exists; overwrite?",
                    }, function(choice)
                        if choice == "Yes" then
                            vim.cmd.saveas { entry.path, bang = true, mods = { silent = true } }
                        end
                    end)
                end)

                return true
            end
        })
    end,
    { desc = "[S]ave as" }
)
