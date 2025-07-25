return {
  "windwp/nvim-ts-autotag",
  ft = {
    "javascript",
    "typescript",
    "html",
    "css",
    "json",
    "yaml",
    "markdown",
    "vue",
    "svelte",
  },
  config = function()
    require("nvim-ts-autotag").setup()
  end
}
