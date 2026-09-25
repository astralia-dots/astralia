-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

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
