return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        filesystem = {
          window = {
            mappings = {
              ["l"] = "set_root", 
              ["h"] = "navigate_up",
            },
          },
          filtered_items = {
            visible = true,
            hide_gitignored = false,
            hide_dotfiles = false,
            hide_by_name = {
            ".git",
            },
          },
        },
      })
    end,
  }
}
