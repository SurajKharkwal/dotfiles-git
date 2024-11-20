-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everblush",
  transparency = true,
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  override = {
    ["nvim-treesitter/nvim-treesitter"] = {
      ensure_installed = {
        "bash",
        "comment",
        "cpp",
        "css",
        "graphql",
        "html",
        "javascript",
        "json",
        "lua",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },

    ["williamboman/mason.nvim"] = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev
        "css-lsp",
        "deno",
        "emmet-ls",
        "eslint-lsp",
        "html-lsp",
        "json-lsp",
        "typescript-language-server",
        "yaml-language-server",

        -- shell
        "shellcheck",
      },
    },
    ["nvim-tree"] = {
      require("nvim-tree").setup {
        view = {
          side = "right",
          width = 25,
        },
        renderer = {
          group_empty = true,
          root_folder_label = false, -- Disable showing root folder at the top
        },
      },
    },
  },
}

M.ui = {
  tabufline = {
    enabled = true,
    lazyload = false,
    order = { "buffers", "tabs" },
    modules = nil,
  },
}

return M
