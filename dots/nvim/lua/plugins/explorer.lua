return {
  "folke/snacks.nvim",
  init = function()
    -- `nvim <dir>`: cd into it (snacks already shows the dashboard for a lone directory arg)
    local dir = vim.fn.argc() == 1 and vim.fn.argv(0) or nil
    if dir and vim.fn.isdirectory(dir) == 1 then
      vim.fn.chdir(dir)
    end
  end,
  keys = {
    { "<leader><space>", false },
    { "<C-p>", function() LazyVim.pick("files")() end, desc = "Find Files (Root Dir)" },
  },
  opts = {
    explorer = { replace_netrw = false }, -- don't auto-open the explorer for directories
    picker = {
      sources = {
        explorer = {
          hidden = true, -- show dotfiles (incl. .gitignore)
          ignored = true, -- show git-ignored files
          win = {
            list = {
              keys = {
                ["<M-Left>"] = "explorer_close_all", -- collapse all directories (VSCode muscle memory)
                ["<BS>"] = false, -- don't climb out of the project root
              },
            },
          },
        },
      },
    },
  },
}
