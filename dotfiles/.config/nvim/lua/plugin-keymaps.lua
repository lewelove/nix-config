-- Lazy

-- Telescope
vim.keymap.set("n", "<C-f>", function()
  require("telescope.builtin").find_files()
end, { desc = "Telescope Find Files" })

vim.keymap.set("n", "<C-g>", function()
  require("telescope.builtin").live_grep()
end, { desc = "Telescope Live Grep" })

