# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration using lazy.nvim for plugin management. The config follows a modular pattern where each plugin gets its own file in `lua/plugins/`.

## Architecture

### Plugin Management System

**lazy.nvim** auto-loads all files from `lua/plugins/`. No need to modify `init.lua` or `plugins.lua` when adding plugins.

**Load Order:**
1. `init.lua` - Bootstraps lazy.nvim
2. `lua/vim-options.lua` - Sets leader key (Space) and core options BEFORE plugins
3. `lua/plugins/*.lua` - All plugin specs loaded automatically

### LSP Configuration (Three-Layer System)

1. **mason.nvim** - Installs LSP servers, formatters, linters (`:Mason`)
2. **mason-lspconfig.nvim** - Auto-installs: lua_ls, ts_ls, gopls, pyright, ruff
3. **nvim-lspconfig** - Configures each server

**New Neovim 0.11+ API pattern used throughout:**
```lua
vim.lsp.config("server_name", { options })
vim.lsp.enable("server_name")
```
The old `require("lspconfig").server_name.setup()` pattern is commented out but preserved for reference.

**Configured LSP servers:** gopls, pyright, ruff, lua_ls, stylua, html, ts_ls, cssls, jsonls

**Special configurations:**
- Pyright disables organize imports and analysis (delegates to ruff)
- All servers use `cmp_nvim_lsp.default_capabilities()` for completion

### Linting & Formatting (none-ls)

Located in `lua/plugins/none-ls.lua`. Auto-formats on save.

**Configured sources:**
- Python: mypy (diagnostics), black (formatting)
- Lua: stylua (formatting)
- JS/TS: prettierd (formatting), eslint_d (diagnostics + code actions)

**ESLint configuration note:** Uses simple `eslint_d` from none-ls-extras. A complex custom setup for monorepos/subdirectories is preserved in comments but not active.

### File Structure

```
nvim/
├── init.lua                # Entry point
├── lazy-lock.json          # Plugin versions (39 plugins)
└── lua/
    ├── vim-options.lua     # Core settings, leader key
    └── plugins/            # One file per plugin
        ├── lsp-config.lua
        ├── none-ls.lua
        ├── completions.lua
        ├── treesitter.lua
        ├── telescope.lua
        ├── neo-tree.lua
        ├── debugging.lua
        └── ... (17 total plugin files)
```

## Common Commands

### Plugin Management
```vim
:Lazy              " Plugin manager UI
:Lazy sync         " Install/update plugins
:Lazy clean        " Remove unused plugins
```

### LSP & Tools
```vim
:Mason             " Install LSP servers, formatters, linters
:LspInfo           " Show active LSP servers
:LspRestart        " Restart LSP servers
```

### Diagnostics & Testing
```vim
:checkhealth       " Run health checks
:TSUpdate          " Update treesitter parsers
```

### Debugging
```vim
:lua require("dap").continue()       " Start/continue debugging
:lua require("dapui").toggle()       " Toggle debug UI
```

## Key Bindings

**Leader key:** Space

### Global
- `<leader>w` - Save
- `<leader>q` - Quit
- `<leader>gf` - Format buffer
- `<C-p>` - Find files (Telescope)
- `<leader>fg` - Live grep
- `<leader>n` - Toggle file tree

### LSP
- `K` - Hover documentation
- `gd` - Go to definition
- `<leader>ca` - Code action
- `<leader>gr` - Go to references

### Testing (vim-test + vimux)
- `<leader>t` - Test nearest
- `<leader>T` - Test file
- `<leader>ta` - Test suite

### Git
- `<leader>gp` - Preview hunk
- `<leader>gt` - Toggle line blame
- `<leader>hh` - Next hunk
- `<leader>hj` - Previous hunk

### Debugging
- `<leader>du` - Toggle DAP UI
- `<leader>dt` - Toggle breakpoint
- `<leader>dc` - Continue

## Adding New Plugins

Create a new file in `lua/plugins/`:

```lua
return {
  "author/plugin-name",
  dependencies = { "required/plugin" },  -- Optional
  event = "VeryLazy",                    -- Lazy load after UI
  config = function()
    require("plugin-name").setup({
      -- options
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>x", ":Cmd<CR>", { desc = "Description" })
  end,
}
```

**Lazy loading strategies:**
- `event = "VeryLazy"` - Load after UI
- `ft = { "python", "lua" }` - Load on filetype
- `cmd = "CommandName"` - Load on command
- `keys = "<leader>x"` - Load on keymap
- `lazy = false` - Load immediately

Restart Neovim or run `:Lazy sync`. No need to modify other files.

## Modifying Configurations

### Adding LSP Server
1. Add to `ensure_installed` in `lua/plugins/lsp-config.lua`
2. Add configuration:
```lua
vim.lsp.config("server_name", {
  capabilities = capabilities,
  settings = { ... },
})
vim.lsp.enable("server_name")
```

### Adding Formatter/Linter
1. Install via `:Mason`
2. Add to `sources` in `lua/plugins/none-ls.lua`:
```lua
null_ls.builtins.formatting.toolname
null_ls.builtins.diagnostics.toolname
```

### Adding Treesitter Language
Auto-installs on buffer open (`auto_install = true` is enabled).

## Important Patterns

1. **Pass capabilities to all LSP servers** for completion support:
```lua
local capabilities = require("cmp_nvim_lsp").default_capabilities()
```

2. **Use new LSP API** (Neovim 0.11+):
```lua
vim.lsp.config() and vim.lsp.enable()
```

3. **Conditional plugin loading**:
```lua
if condition then
  return { plugin_spec }
else
  return {}
end
```

4. **Auto-format on save** is configured in none-ls.lua's `on_attach` function.

## Debugging Configurations

**JavaScript/TypeScript:**
- Adapter: pwa-node
- Debugger path: `~/.local/share/bin/js-debug/src/dapDebugServer.js`
- Includes Jest test configuration

**Go:** Uses nvim-dap-go plugin (auto-configured)

**Python:** Uses nvim-dap-python with debugpy from Mason

## Known Issues

1. **ESLint in subdirectories** - If node_modules is not at project root, eslint_d may fail. Ensure node_modules exists at the git root, or configure eslint to look in subdirectories.

2. **Project.nvim deprecation** - Uses deprecated `vim.lsp.buf_get_clients()`, should use `vim.lsp.get_clients()`.

3. **Theme mismatch** - Main colorscheme is Catppuccin Mocha, but lualine uses Dracula theme.

## Special Features

- **OSC52 clipboard** - Auto-enables in Docker/SSH for system clipboard sync
- **Tmux integration** - Seamless navigation between vim and tmux panes
- **Claude Code integration** - Toggle with `<C-,>`
- **Ollama integration** - Local LLM with qwen3:14b model
