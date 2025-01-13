vim.g.mapleader = " " -- Set leader key before Lazy

-- Disabled for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("joel.lazy_init")

-- Settings
--vim.cmd.colorscheme("tokyonight")
vim.opt.nu = true             -- set line numbers -- set line numbers
vim.opt.relativenumber = true -- use relative line numbers

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

vim.keymap.set("n", "<C-S>", ":w<CR>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("i", "<C-S>", "<ESC>:w<CR>", { noremap = true, silent = true, desc = "Save" })
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear Highlight" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close Tab" })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf' },
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>bd<cr>', { silent = true, buffer = true })
  end,
})

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
vim.keymap.set("n", ",d", require('fzf-lua').diagnostics_workspace, { desc = "Fzf Workspace Diagnosics" })
vim.keymap.set("n", "gr", require('fzf-lua').lsp_references, { desc = "Fzf References" })
vim.keymap.set("n", "<leader>la", require('fzf-lua').lsp_code_actions, { desc = "Code actions" })

-- Tree
vim.keymap.set("n", ",n", ":NvimTreeToggle<CR>", { desc = "Fzf History" })

-- Copilot
vim.keymap.set('i', '<C-L>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

-- Copilot Chat
vim.keymap.set('n', '<leader>ch', ':CopilotChat<CR>', { desc = "Copilot Chat" })

vim.keymap.set('n', '<leader>ccq', function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
      require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
    end
  end,
  { desc = "CopilotChat - Quick chat" })
