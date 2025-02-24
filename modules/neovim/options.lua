-- colorscheme
vim.cmd.colorscheme("quiet")

-- text
vim.g.have_nerd_font = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.colorcolumn = "120"

-- modes
vim.opt.mouse = "a"
vim.opt.showmode = false

-- clipboard
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- undo
vim.opt.undofile = true

-- search, replace
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.hlsearch = true

-- time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- window
vim.opt.splitright = true
vim.opt.splitbelow = true
