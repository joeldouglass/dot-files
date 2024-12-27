vim.g.mapleader = " " -- Set leader key before Lazy

-- Disabled for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("joel.lazy_init")

-- Settings
--vim.cmd.colorscheme("tokyonight")
vim.opt.nu = true                 -- set line numbers -- set line numbers
vim.opt.relativenumber = true     -- use relative line numbers

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '▲',
      [vim.diagnostic.severity.HINT] = '⚑',
      [vim.diagnostic.severity.INFO] = '»',
    },
  },
})

-- set tab size to 2 spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.incsearch = true -- incremental search

vim.opt.termguicolors = true

vim.g.ackprg = 'rg --vimgrep --no-heading'

-- Keymaps

-- Save
vim.keymap.set("n", "<C-S>", ":w<CR>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("i", "<C-S>", "<ESC>:w<CR>", { noremap = true, silent = true, desc = "Save" })

-- nmap <silent> <leader>/ :nohlsearch<CR>
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear Highlight" })

vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close Tab" })


-- Window movement
vim.keymap.set("n", "<C-K>", ":wincmd k<CR>", { noremap = true, silent = true, desc = "Move Window Up" })
vim.keymap.set("n", "<C-J>", ":wincmd j<CR>", { noremap = true, silent = true, desc = "Move Window Down" })
vim.keymap.set("n", "<C-H>", ":wincmd h<CR>", { noremap = true, silent = true, desc = "Move Window Left" })
vim.keymap.set("n", "<C-L>", ":wincmd l<CR>", { noremap = true, silent = true, desc = "Move Window Right" })

-- Switch between buffers
vim.keymap.set("n", ",m", "<C-6>", { noremap = true, silent = true, desc = "Switch Buffer" })

-- FZF
vim.keymap.set("n", ",b", require('fzf-lua').buffers, { desc = "Fzf Buffers" })
vim.keymap.set("n", ",f", require('fzf-lua').files, { desc = "Fzf History" })

-- Tree
vim.keymap.set("n", ",n", ":NvimTreeToggle<CR>", { desc = "Fzf History" })

-- Copilot
vim.keymap.set('i', '<C-L>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
