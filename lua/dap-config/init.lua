-- local dap = require("dap")
--
local dap_install = require("dap-install")

dap_install.setup({
	installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
})

-- Configure each dap server already installed
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
	dap_install.config(debugger)
end

-- dap.adapters.chrome = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { install_path .. "vscode-chrome-debug\\out\\src\\chromeDebug.js" }, -- TODO adjust
-- }
--
-- dap.adapters.node2 = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { install_path .. "vscode-node-debug2\\out\\src\\nodeDebug.js" },
-- }
--
-- dap.configurations.javascript = { -- change this to javascript if needed
-- 	{
-- 		name = "Launch",
-- 		type = "node2",
-- 		request = "launch",
-- 		program = "${file}",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		console = "integratedTerminal",
-- 	},
-- 	{
-- 		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
-- 		name = "Attach to process",
-- 		type = "node2",
-- 		request = "attach",
-- 		processId = require("dap.utils").pick_process,
-- 	},
-- }
--
-- dap.configurations.typescript = { -- change this to javascript if needed
-- 	{
-- 		name = "Launch",
-- 		type = "node2",
-- 		request = "launch",
-- 		program = "${file}",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		console = "integratedTerminal",
-- 	},
-- 	{
-- 		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
-- 		name = "Attach to process",
-- 		type = "node2",
-- 		request = "attach",
-- 		processId = require("dap.utils").pick_process,
-- 	},
-- }
--
-- dap.configurations.javascriptreact = { -- change this to javascript if needed
-- 	{
-- 		type = "chrome",
-- 		request = "attach",
-- 		program = "${file}",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		port = 9222,
-- 		webRoot = "${workspaceFolder}",
-- 	},
-- }
--
-- dap.configurations.typescriptreact = { -- change to typescript if needed
-- 	{
-- 		type = "chrome",
-- 		request = "attach",
-- 		program = "${file}",
-- 		cwd = vim.fn.getcwd(),
-- 		sourceMaps = true,
-- 		protocol = "inspector",
-- 		port = 9222,
-- 		webRoot = "${workspaceFolder}",
-- 	},
-- }
