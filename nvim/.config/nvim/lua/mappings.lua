require "nvchad.mappings"

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Disable mappings
nomap("i", "<C-k>")
nomap("n", "<C-k>")

--save and quit
map({ "n", "v" }, "<leader>w", "<cmd> w <cr>",{ desc = "Save changes" })
map({ "n", "v" }, "<leader>q", "<cmd> q <cr>",{ desc = "Quit (:q)" })

--open find files
map("n", "<leader><leader>", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })


-- Move line down
map("n", "<A-j>", "<cmd>m .+1<CR>==", {desc = "Move line down"})
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", {desc = "Move line down"})
map("v", "<A-j>", ":m '>+1<CR>gv=gv", {desc = "Move line down"})

-- Move line up
map("n", "<A-k>", "<cmd>m .-2<CR>==", {desc = "Move line up"})
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", {desc = "Move line up"})
map("v", "<A-k>", ":m '<-2<CR>gv=gv", {desc = "Move line up"})


nomap("n", "<leader>e")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
nomap('n', '<C-n>')

-- Tmux navigator

map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "Tmux Navigator Down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "Tmux Navigator Up" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "Tmux Navigator Right" })
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "Tmux Navigator Left" })
