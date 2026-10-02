return {
  "folke/snacks.nvim",
  init = function()
    -- `nvim <dir>`: cd into it
    local dir = vim.fn.argc() == 1 and vim.fn.argv(0) or nil
    if dir and vim.fn.isdirectory(dir) == 1 then
      vim.fn.chdir(dir)
    end
  end,
  keys = {
    { "<leader><space>", false },
    { "<leader>e", false },
    {
      "<C-S-e>",
      function() Snacks.explorer({ cwd = LazyVim.root() }) end,
      mode = { "n", "i", "v", "t" },
      desc = "Explorer Snacks (root dir)",
    },
    { "<C-p>", function() LazyVim.pick("files")() end, desc = "Find Files (Root Dir)" },
  },
  opts = {
    image = { enabled = true },
    explorer = { replace_netrw = false },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          ignored = true,
          actions = {
            confirm = function(picker, item, action)
              if item and not item.dir and item.file:match("%.pdf$") and vim.fn.executable("zathura") == 1 then
                vim.fn.jobstart({ "zathura", item.file }, { detach = true })
                return
              end
              return require("snacks.explorer.actions").actions.confirm(picker, item, action)
            end,
          },
          win = {
            list = {
              keys = {
                ["<M-Left>"] = "explorer_close_all",
                ["<BS>"] = false,
              },
            },
          },
        },
      },
    },
  },
}
