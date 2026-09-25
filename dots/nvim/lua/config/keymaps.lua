-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Close all buffers and return to the dashboard
vim.keymap.set("n", "<leader>ba", function()
  Snacks.bufdelete.all()
  Snacks.dashboard()
end, { desc = "Close All Buffers (Dashboard)" })

-- Resize from terminal mode too (e.g. the Claude panel grabs focus in insert mode)
vim.keymap.set("t", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("t", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
vim.keymap.set("t", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("t", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
