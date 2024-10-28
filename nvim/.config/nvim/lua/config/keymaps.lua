-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local set = vim.keymap.set

set("i", "jk", "<ESC>", { noremap = true, silent = true, desc = "<ESC>" })

set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, desc = "Save window" })
set("n", "<leader>q", "<cmd>q<cr>", { noremap = true, desc = "Close window" })
