return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
  },
  config = function()
    require("neo-tree").setup({
      event_handlers = {
        {
          -- auto close
          event = "file_opened",
          handler = function()
            vim.cmd("Neotree close")
          end,
        },
      },
      close_if_last_window = true,
      enable_git_status = true,
      auto_clean_after_session_restore = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_hidden = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          always_show = {
            "*.json",
            "*.yml",
            "*.yaml",
          },
          never_show = {},
          never_show_by_pattern = {},
        },
      },
    })
  end,
}

