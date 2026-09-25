-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Autosave like VSCode's "onFocusChange": when leaving a window/buffer
-- (Ctrl+h/j/k/l, buffer switch) or when nvim itself loses focus
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

-- Keep cwd at the project root of the file being edited (like a VSCode workspace),
-- so the explorer/pickers don't fall back to wherever nvim was launched (e.g. ~)
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("project_cwd", { clear = true }),
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= "" or vim.api.nvim_buf_get_name(ev.buf) == "" then
      return
    end
    local root = LazyVim.root({ buf = ev.buf })
    if root ~= vim.fn.getcwd() then
      vim.fn.chdir(root)
    end
  end,
})
