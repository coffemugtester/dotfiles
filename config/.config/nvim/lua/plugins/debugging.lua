return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			-- /Users/danielalfaro/.local/share/bin/js-debug/src

			require("dapui").setup()
			require("dap-go").setup()
			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					-- 💀 Make sure to update this path to point to your installation
					args = { vim.fn.expand("~/.local/share/bin/js-debug/src/dapDebugServer.js"), "${port} " },
					-- args = { "$HOME/.local/share/bin/js-debug/src/dapDebugServer.js", "${port}" },
				},
			}
			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug Jest Tests",
						-- trace = true, -- include debugger info
						runtimeExecutable = "node",
						runtimeArgs = {
							"./node_modules/jest/bin/jest.js",
							"--runInBand",
						},
						rootPath = "${workspaceFolder}",
						cwd = "${workspaceFolder}",
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
						-- Add this to skip node_modules and Node's internal code
						skipFiles = {
							"<node_internals>/**",
							"**/node_modules/**",
						},
						-- 🚫 don't even try to load sourcemaps from node_modules
						resolveSourceMapLocations = { "**", "!**/node_modules/**" },
					},
				}
			end
			-- require("dap").configurations.javascript = {
			--   {
			--     type = "pwa-node",
			--     request = "launch",
			--     name = "Launch file",
			--     program = "${file}",
			--     cwd = "${workspaceFolder}",
			--   },
			--   {
			--     type = "pwa-node",
			--     request = "attach",
			--     name = "Attach",
			--     processId = require("dap.utils").pick_process,
			--     cwd = "${workspaceFolder}",
			--   },
			--   {
			--     type = "pwa-node",
			--     request = "launch",
			--     name = "Debug Jest Tests",
			--     -- trace = true, -- include debugger info
			--     runtimeExecutable = "node",
			--     runtimeArgs = {
			--       "./node_modules/jest/bin/jest.js",
			--       "--runInBand",
			--     },
			--     rootPath = "${workspaceFolder}",
			--     cwd = "${workspaceFolder}",
			--     console = "integratedTerminal",
			--     internalConsoleOptions = "neverOpen",
			--   },
			-- }

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<leader>du", function()
				require("dapui").toggle({})
			end, { desc = "DAP UI" })
			vim.keymap.set({ "n", "v" }, "<leader>de", function()
				require("dapui").eval()
			end, { desc = "Eval" })
			vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})
		end,
	},
	-- {
	--   "mxsdev/nvim-dap-vscode-js",
	--   dependencies = { "mfussenegger/nvim-dap" },
	--   config = function()
	--     -- Your dap-vscode-js setup code here
	--     require("dap-vscode-js").setup({
	--       -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	--       debugger_path = "$HOME/.local/share/bin/js-debug/src/dapDebugServer.js", -- Path to vscode-js-debug installation.
	--       -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	--       adapters = { "pwa-node" },                                           -- which adapters to register in nvim-dap
	--       -- adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	--       -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	--       -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	--       -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
	--     })
	--
	--     for _, language in ipairs({ "typescript", "javascript" }) do
	--       require("dap").configurations[language] = {
	--         {
	--           type = "pwa-node",
	--           request = "launch",
	--           name = "Launch file",
	--           program = "${file}",
	--           cwd = "${workspaceFolder}",
	--         },
	--         {
	--           type = "pwa-node",
	--           request = "attach",
	--           name = "Attach",
	--           processId = require("dap.utils").pick_process,
	--           cwd = "${workspaceFolder}",
	--         },
	--         {
	--           type = "pwa-node",
	--           request = "launch",
	--           name = "Debug Jest Tests",
	--           -- trace = true, -- include debugger info
	--           runtimeExecutable = "node",
	--           runtimeArgs = {
	--             "./node_modules/jest/bin/jest.js",
	--             "--runInBand",
	--           },
	--           rootPath = "${workspaceFolder}",
	--           cwd = "${workspaceFolder}",
	--           console = "integratedTerminal",
	--           internalConsoleOptions = "neverOpen",
	--         },
	--       }
	--     end
	--   end,
	-- },
}
