-- ~/.local/bin is only on PATH in interactive zsh, so nvim launched from a
-- keybind/launcher can't find `claude`; point at the binary directly
local claude_bin = vim.fn.expand("~/.local/bin/claude")

-- Run a :ClaudeCode* command only if Claude Code is installed
local function gated(cmd)
	return function()
		if vim.fn.executable(claude_bin) == 1 then
			vim.cmd(cmd)
		else
			vim.notify("Claude Code is not installed", vim.log.levels.WARN, { title = "Claude" })
		end
	end
end

return {
	"coder/claudecode.nvim",
	keys = {
		{ "<leader>ac", gated("ClaudeCode"), desc = "Toggle Claude" },
		{ "<leader>af", gated("ClaudeCodeFocus"), desc = "Focus Claude" },
		{ "<leader>ar", gated("ClaudeCode --resume"), desc = "Resume Claude" },
		{ "<leader>aC", gated("ClaudeCode --continue"), desc = "Continue Claude" },
	},
	opts = {
		terminal_cmd = claude_bin,
		terminal = {
			split_width_percentage = 0.4,
			auto_insert = false, -- open/focus the pane in normal mode; press i to type
			-- LazyVim gives every Snacks terminal Ctrl+/ = hide, which hid Claude instead of
			-- toggling the shell terminal; drop them so the global Ctrl+/ map applies here
			snacks_win_opts = { keys = { hide_slash = false, hide_underscore = false } },
		},
	},
	init = function()
		-- Remember the panel width across toggles (the plugin re-creates the split
		-- at split_width_percentage every time it's shown)
		local width
		local function claude_buf()
			local ok, term = pcall(require, "claudecode.terminal")
			return ok and term.get_active_terminal_bufnr() or nil
		end
		local group = vim.api.nvim_create_augroup("claude_panel_width", { clear = true })

		-- Save the width as the panel is hidden (WinClosed fires for hides too)
		vim.api.nvim_create_autocmd("WinClosed", {
			group = group,
			callback = function(ev)
				local win = tonumber(ev.match)
				local buf = claude_buf()
				if buf and win and vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
					width = vim.api.nvim_win_get_width(win)
				end
			end,
		})

		vim.api.nvim_create_autocmd("BufWinEnter", {
			group = group,
			callback = function(ev)
				if not width or ev.buf ~= claude_buf() then
					return
				end
				local function apply()
					for _, win in ipairs(vim.fn.win_findbuf(ev.buf)) do
						vim.api.nvim_win_set_width(win, width)
					end
				end
				apply()
				vim.schedule(apply) -- again after the plugin finishes laying out the split
			end,
		})
	end,
}
