return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
    {

      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = false,
          follow = true,
        })
      end,
      desc = "Find Files",
    },
    {

      "<leader>/",
      function()
        require("telescope.builtin").live_grep({
          additional_args = function()
            return { "--hidden" }
          end,
        })
      end,
      desc = "Live grep",
    },
    {
      "<leader>sf",
      function()
        local telescope = require("telescope")

        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end

        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end,
      desc = "Open File Browser on current buffer",
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
      wrap_results = true,
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "bottom" },
      sorting_strategy = "descending",
      file_ignore_patterns = { "node_modules", "type", "%.git/", ".git", ".git/" },
      winblend = 0,
      mappings = {
        n = {},
      },
    })
    opts.pickers = {
      find_files = {
        follow = true,
        find_files = { "rg", "--ignore", "-L", "--hidden", "--files" },
      },
      diagnostics = {
        theme = "ivy",
        initial_mode = "normal",
        layout_config = {
          preview_cutoff = 9999,
        },
      },
    }
    opts.extensions = {
      file_browser = {
        theme = "dropdown",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          -- your custom insert mode mappings
          ["n"] = {
            -- your custom normal mode mappings
            ["N"] = fb_actions.create,
            ["h"] = fb_actions.goto_parent_dir,
            ["<C-u>"] = function(prompt_bufnr)
              for i = 1, 10 do
                actions.move_selection_previous(prompt_bufnr)
              end
            end,
            ["<C-d>"] = function(prompt_bufnr)
              for i = 1, 10 do
                actions.move_selection_next(prompt_bufnr)
              end
            end,
            ["<PageUp>"] = actions.preview_scrolling_up,
            ["<PageDown>"] = actions.preview_scrolling_down,
          },
        },
      },
    }
    telescope.setup(opts)
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
  end,
}
