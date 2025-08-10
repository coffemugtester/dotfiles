-- Might have to fork project if it's not updated on time
-- ==============================================================================
-- vim.deprecated:                                                           1 ⚠️
--
--  ~
-- - ⚠️ WARNING vim.lsp.buf_get_clients() is deprecated. Feature will be removed in Nvim 0.12
--   - ADVICE:
--     - use vim.lsp.get_clients() instead.
--     - stack traceback:
--         /Users/danielalfaro/.local/share/nvim/lazy/project.nvim/lua/project_nvim/project.lua:16
--         /Users/danielalfaro/.local/share/nvim/lazy/project.nvim/lua/project_nvim/project.lua:203
--         /Users/danielalfaro/.local/share/nvim/lazy/project.nvim/lua/project_nvim/project.lua:248
--         lua:1
--         [C]:-1
--         [C]:-1
--         /Users/danielalfaro/.local/share/nvim/lazy/neo-tree.nvim/lua/neo-tree/setup/netrw.lua:65
--         [C]:-1
--         /Users/danielalfaro/.local/share/nvim/lazy/neo-tree.nvim/lua/neo-tree/utils/init.lua:125
--         /Users/danielalfaro/.local/share/nvim/lazy/neo-tree.nvim/lua/neo-tree/utils/init.lua:70
--         vim/_editor.lua:0
-- vim/_editor.lua:0

return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      -- Manual mode doesn't automatically change your root directory, so you have
      -- the option to manually do so using `:ProjectRoot` command.
      manual_mode = true,

      -- Methods of detecting the root directory. **"lsp"** uses the native neovim
      -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
      -- order matters: if one is not detected, the other is used as fallback. You
      -- can also delete or rearangne the detection methods.
      -- detection_methods = { "lsp", "pattern" },

      -- All the patterns used to detect root dir, when **"pattern"** is in
      -- detection_methods
      -- patterns = { "package.json", ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile" },

      -- Table of lsp clients to ignore by name
      -- eg: { "efm", ... }
      -- ignore_lsp = {},

      -- Don't calculate root dir on specific directories
      -- Ex: { "~/.cargo/*", ... }
      -- exclude_dirs = {},

      -- Show hidden files in telescope
      show_hidden = true,

      -- When set to false, you will get a message when project.nvim changes your
      -- directory.
      -- silent_chdir = true,

      -- What scope to change the directory, valid options are
      -- * global (default)
      -- * tab
      -- * win
      -- scope_chdir = 'global',

      -- Path where project.nvim will store the project history for use in
      -- telescope
      -- datapath = vim.fn.stdpath("data"),
    })
  end,
}
