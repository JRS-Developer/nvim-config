local dap = require('dap')

local install_path = vim.fn.stdpath("data") .. "\\dapinstall\\"

dap.adapters.chrome =  {
  type = "executable",
  command = "node",
  args = {install_path .. "vscode-chrome-debug\\out\\src\\chromeDebug.js"} -- TODO adjust
}

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {install_path .. 'vscode-node-debug2\\out\\src\\nodeDebug.js'},
}

dap.configurations.javascript = { -- change this to javascript if needed
    {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

dap.configurations.typescript = { -- change this to javascript if needed
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
  },
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

dap.configurations.typescriptreact = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map('n', '<leader>ds', ':lua require"dap".continue()<CR>', opts) -- Start debugging
map('n', '<leader>db', ':lua require"dap".toggle_breakpoint()<CR>', opts) -- Toggle breakpoint
map('n', '<leader>dt', ':lua require"dap".step_over()<CR>', opts) -- Step over
map('n', '<leader>di', ':lua require"dap".step_into()<CR>', opts) -- Step into
map('n', '<leader>do', ':lua require"dap".step_out()<CR>', opts) -- Step out
map('n', '<leader>dr', ':lua require"dap".repl.toggle()<CR>', opts) -- Toggle REPL
map('n', '<leader>dc', ':lua require"dap".terminate()<CR>', opts) -- End the debugging session
