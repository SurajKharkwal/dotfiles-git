return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "vim", "lua", "vimdoc", "html", "css" },
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false, -- Load immediately to enable seamless tmux navigation
  },

  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },

  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- if you install parsers with `nvim-treesitter`
    config = function()
      require("treesj").setup {
        --[[ your config ]]
      }
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    "mattn/emmet-vim",
    lazy = true,
    config = function()
      vim.g.user_emmet_leader_key = "T"
    end, -- Configure emmet for fast HTML/CSS workflow
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },

  {
    "prisma/vim-prisma",
    ft = "prisma",
  },

  "nvzone/volt",
  { "nvzone/timerly", cmd = "TimerlyToggle" },
}
