-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Close all buffers and return to the dashboard
vim.keymap.set("n", "<leader>ba", function()
  Snacks.bufdelete.all()
  Snacks.dashboard()
end, { desc = "Close All Buffers (Dashboard)" })

-- Ctrl+Left/Right move the split border in the arrow's direction, so a right-edge
-- panel (Claude) grows with Left; also in terminal mode (Claude grabs focus in insert mode)
local function nudge(dir)
  return function()
    local right_edge = vim.fn.winnr("l") == vim.fn.winnr()
    vim.cmd("vertical resize " .. (((dir == "left") == right_edge) and "+2" or "-2"))
  end
end
vim.keymap.set({ "n", "t" }, "<C-Left>", nudge("left"), { desc = "Move Split Border Left" })
vim.keymap.set({ "n", "t" }, "<C-Right>", nudge("right"), { desc = "Move Split Border Right" })

-- Height resize from terminal mode too
vim.keymap.set("t", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("t", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
