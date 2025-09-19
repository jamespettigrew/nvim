vim.keymap.set("n", "<leader>fb",
    function()
        Snacks.picker.explorer({
            layout = { preset = "select", preview = true },
        })
    end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fs",
    function()
        vim.lsp.buf.format()
        vim.cmd.update()
    end,
    { desc = "[s]ave" }
)
vim.keymap.set("n", "<leader>fS",
    function()
        Snacks.picker.explorer({
            title = "Save As",
            layout = {
                layout = {
                    backdrop = false,
                    width = 0.5,
                    min_width = 80,
                    height = 0.4,
                    min_height = 3,
                    box = "vertical",
                    border = "rounded",
                    title = "{title}",
                    title_pos = "center",
                    { win = "list", border = "none" },
                },
            },
            tree = false,
            auto_close = true,
            actions = {
                custom_select = function(picker, item)
                    if item.dir then
                        picker:set_cwd(picker:dir())
                        picker:find()
                    else
                        picker:close()
                        vim.ui.select({ "Yes", "No" }, {
                            prompt = "Are you sure you want to save as " .. item.file .. "?",
                        }, function(choice)
                            if choice == "Yes" then
                                vim.cmd.saveas { item.file, bang = true, mods = { silent = true } }
                            end
                        end)
                    end
                end,
                custom_up = function(picker, item)
                    picker:set_cwd(vim.fs.dirname(picker:cwd()))
                    picker:find()
                end
            },
            win = {
                list = {
                    keys = {
                        ["<CR>"] = "custom_select",
                        ["<BS>"] = "custom_up",
                    }
                }
            }
        })
    end, { desc = "Save As" })
