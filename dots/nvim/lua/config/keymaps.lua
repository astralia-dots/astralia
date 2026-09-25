-- Close all file buffers into the dashboard, leaving Claude/explorer panes alone. Dashboard
-- first: bufdelete refills emptied windows with the Claude terminal, and a windowless
-- Snacks.dashboard() is a fullscreen float that hides everything opened after it
vim.keymap.set("n", "<leader>ba", function()
  local function is_file(b)
    return vim.bo[b].buftype == ""
  end
  local wins = vim.tbl_filter(function(w)
    return vim.api.nvim_win_get_config(w).relative == "" and is_file(vim.api.nvim_win_get_buf(w))
  end, vim.api.nvim_tabpage_list_wins(0))
  if not wins[1] then
    return Snacks.notify.warn("No editor window for the dashboard")
  end
  for i = 2, #wins do
    vim.api.nvim_win_close(wins[i], false)
  end
  Snacks.dashboard({ win = wins[1] })
  Snacks.bufdelete.delete({ filter = is_file })
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
