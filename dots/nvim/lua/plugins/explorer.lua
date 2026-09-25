return {
  "folke/snacks.nvim",
  init = function()
    -- `nvim <dir>`: cd into it and show the dashboard instead of an explorer/netrw
    local dir = vim.fn.argc() == 1 and vim.fn.argv(0) or nil
    if dir and vim.fn.isdirectory(dir) == 1 then
      vim.fn.chdir(dir) -- snacks' dashboard already shows for a single directory arg
    end
  end,
  opts = {
    explorer = { replace_netrw = false }, -- don't auto-open the explorer for directories
    picker = {
      sources = {
        explorer = {
          ignored = true, -- show git-ignored files
          win = {
            list = {
              keys = {
                ["<M-Left>"] = "explorer_close", -- collapse directory (VSCode muscle memory)
                ["<BS>"] = false, -- don't climb out of the project root
              },
            },
          },
        },
      },
    },
  },
}
