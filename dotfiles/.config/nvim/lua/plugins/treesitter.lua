return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ts = require("nvim-treesitter")
    
    ts.setup()

    require("nvim-treesitter.install").prefer_git = true

    local parsers = { 
      "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "html", "css", "json",
      "markdown", "markdown_inline", "nix", "toml",
    }
    ts.install(parsers)

    vim.treesitter.language.register("markdown", "md")
    vim.treesitter.language.register("javascript", "js")

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end,
}
