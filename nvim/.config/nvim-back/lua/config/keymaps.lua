-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set
local del = vim.keymap.del

-- Insert mode keymap for exiting insert mode with "jk"
set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

-- Normal mode keymaps
set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, desc = "Save window" })
set("n", "<leader>q", "<cmd>q<cr>", { noremap = true, desc = "Close window" })
set("n", "<leader>sp", "<cmd>:SudaWrite<cr>", { noremap = true, desc = "Sudo Write" })

-- Delete default navigation keymaps to replace with Tmux navigation
del("n", "<C-h>")
del("n", "<C-j>")
del("n", "<C-k>")
del("n", "<C-l>")

-- Set Tmux navigation keymaps
set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
