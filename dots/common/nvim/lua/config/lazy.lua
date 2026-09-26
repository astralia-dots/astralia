local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		{ import = "lazyvim.plugins.extras.lang.tex" },
		{ import = "plugins" },
	},
	defaults = {
		lazy = false,
		version = false, -- latest git commit; many plugins' releases are outdated
	},
	install = { colorscheme = { "tokyonight", "habamax" } },
	checker = { enabled = true, notify = false }, -- check for plugin updates silently
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin", -- no directory listing on `nvim <dir>` (see plugins/explorer.lua)
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
