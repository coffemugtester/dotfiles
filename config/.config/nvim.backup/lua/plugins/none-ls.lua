return {
  "nvimtools/none-ls.nvim", -- use :Mason to /search and (I)nstall e.g.: stylua
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          -- Optionally specify filetypes:
          filetypes = {
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
        }),
        -- require("none-ls.diagnostics.eslint_d"),
        require("none-ls.diagnostics.eslint").with({
          name = "eslint_d",
          meta = {
            url = "https://github.com/mantoni/eslint_d.js/",
            description = "Like ESLint, but faster.",
            notes = {
              "Once spawned, the server will continue to run in the background. This is normal and not related to null-ls. You can stop it by running `eslint_d stop` from the command line.",
            },
          },
          command = "eslint_d",
        }),
        -- --        null_ls.builtins.formatting.rubocop -- remember to add diagnostics for used languages
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
