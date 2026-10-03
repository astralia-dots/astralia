-- Autosave on focus change
vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave", "BufLeave" }, {
    group = vim.api.nvim_create_augroup("autosave", { clear = true }),
    callback = function(ev)
        local bufs = ev.event == "FocusLost" and vim.api.nvim_list_bufs() or { ev.buf }
        for _, buf in ipairs(bufs) do
            local bo = vim.bo[buf]
            if
                bo.modified
                and bo.modifiable
                and not bo.readonly
                and bo.buftype == ""
                and vim.api.nvim_buf_get_name(buf) ~= ""
            then
                vim.api.nvim_buf_call(buf, function()
                    vim.cmd("silent! update")
                end)
            end
        end
    end,
})

-- Open PDFs in zathura instead of a buffer
if vim.fn.executable("zathura") == 1 then
    vim.api.nvim_create_autocmd("BufReadCmd", {
        group = vim.api.nvim_create_augroup("pdf_zathura", { clear = true }),
        pattern = "*.pdf",
        callback = function(ev)
            vim.fn.jobstart({ "zathura", ev.file }, { detach = true })
            local alt = vim.fn.bufnr("#")
            vim.schedule(function()
                if not vim.api.nvim_buf_is_valid(ev.buf) then
                    return
                end
                -- put windows back on the previous buffer so deleting doesn't close them or leave a blank one
                local has_alt = alt > 0 and alt ~= ev.buf and vim.api.nvim_buf_is_valid(alt)
                local back = has_alt and alt or vim.api.nvim_create_buf(true, false)
                for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
                    vim.api.nvim_win_set_buf(win, back)
                end
                vim.api.nvim_buf_delete(ev.buf, { force = true })
                -- no previous buffer = it was the (wiped) dashboard; bring it back
                if not has_alt then
                    vim.api.nvim_buf_delete(back, { force = true })
                    Snacks.dashboard.open()
                end
            end)
        end,
    })
end
