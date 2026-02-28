return {
  "zaldih/themery.nvim",
  lazy = false,
  dependencies = {
    "marko-cerovac/material.nvim",
  },
  config = function()
    vim.g.material_style = "deep ocean"

    require("themery").setup({
      -- add the config here
      themes = {
        "brightburn",
        "kanagawa",
        "gruvbox",
        "tokyonight-night",
        "rose-pine",
        "solarized",
        "catppuccin-latte",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin-mocha",
        "material",
        "material-darker",
        "material-lighter",
        "material-oceanic",
        "material-palenight",
        "material-deep-ocean",
        "gruvbox-material",
      },
    })
  end,
}
