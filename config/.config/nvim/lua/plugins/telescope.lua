return { 
  'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<C-p>', function()
      builtin.find_files({
        hidden = true,
        no_ignore = true,
        follow = true,
      })
    end, {})
    vim.keymap.set('n', '<leader>fg', function()
      builtin.live_grep({
        additional_args = function()
          return { "--hidden", "--glob", "!.git/*" }
        end
      })
    end, {})
  end
}
