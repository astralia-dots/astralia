return {
  "3rd/image.nvim",
  opts = {
    backend = "ueberzug",
    processor = "magick_cli", -- shells out to `magick`/`convert`, no luarocks build needed
  },
}
