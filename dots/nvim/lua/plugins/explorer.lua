return {
  "folke/snacks.nvim",
  opts = {
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
