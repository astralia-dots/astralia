-- ~/.local/bin is only on PATH in interactive zsh, so nvim launched from a
-- keybind/launcher can't find `claude`; point at the binary directly
return {
  "coder/claudecode.nvim",
  opts = {
    terminal_cmd = vim.fn.expand("~/.local/bin/claude"),
  },
}
