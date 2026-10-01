-- Not on PATH outside interactive zsh
local claude_bin = vim.fn.expand("~/.local/bin/claude")

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
		{ "<C-M-b>", gated("ClaudeCode"), mode = { "n", "i", "t" }, desc = "Toggle Claude" },
		{ "<leader>af", gated("ClaudeCodeFocus"), desc = "Focus Claude" },
		{ "<leader>ar", gated("ClaudeCode --resume"), desc = "Resume Claude" },
		{ "<leader>aC", gated("ClaudeCode --continue"), desc = "Continue Claude" },
	},
	opts = {
		terminal_cmd = claude_bin,
		terminal = {
			split_width_percentage = 0.4,
			auto_insert = false,
			-- Let global Ctrl+/ toggle the shell instead of hiding Claude
			snacks_win_opts = { keys = { hide_slash = false, hide_underscore = false } },
		},
	},
	init = function()
		-- Remember panel width across toggles
		local width
		local function claude_buf()
			local ok, term = pcall(require, "claudecode.terminal")
			return ok and term.get_active_terminal_bufnr() or nil
		end
		local group = vim.api.nvim_create_augroup("claude_panel_width", { clear = true })

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
				vim.schedule(apply) -- after plugin layout
			end,
		})
	end,
}
