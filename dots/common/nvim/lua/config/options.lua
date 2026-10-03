vim.g.root_spec = { "cwd" } -- root is always cwd

-- Blinking beam cursor in terminal mode
vim.opt.guicursor:append("t:ver25-blinkon500-blinkoff500")

-- 4-space indent (LSP/shfmt formatters read these)
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
