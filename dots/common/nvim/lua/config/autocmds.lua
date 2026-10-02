-- Autosave on focus change
vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave", "BufLeave" }, {
  group = vim.api.nvim_create_augroup("autosave", { clear = true }),
  callback = function(ev)
    local bufs = ev.event == "FocusLost" and vim.api.nvim_list_bufs() or { ev.buf }
    for _, buf in ipairs(bufs) do
      local bo = vim.bo[buf]
      if bo.modified and bo.modifiable and not bo.readonly and bo.buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
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
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(ev.buf) then
          vim.api.nvim_buf_delete(ev.buf, { force = true })
        end
      end)
    end,
  })
end
