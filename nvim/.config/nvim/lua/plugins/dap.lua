return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()
			dap.adapters.codelldb = {
				type = "server",
				port = "13000",
				executable = {
					-- CHANGE THIS to your path!
					command = "codelldb",
					args = { "--port", "13000" },

					-- On windows you may have to uncomment this:
					-- detached = false,
				},
			}

			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

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
			vim.keymap.set("n", "<leader>dt", function()
				dap.toggle_breakpoint()
			end)
			vim.keymap.set("n", "<leader>db", function()
				dap.set_breakpoint()
			end)
			vim.keymap.set("n", "<leader>dc", function()
				dap.continue()
			end)
			vim.keymap.set("n", "<leader>dn", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end)
			vim.keymap.set("n", "<leader>do", function()
				dap.step_out()
			end)
		end,
	},
}
