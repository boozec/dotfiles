local dap, dapui = require('dap'), require('dapui')
local dapgo = require('dap-go')
dapui.setup()
dapgo.setup()
dap.listeners.before.attach.dapui_config = function()
 dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
 dapui.open()
end


-- Include the next few lines until the comment only if you feel you need it
dap.listeners.before.event_terminated.dapui_config = function()
 dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
 dapui.close()
end
-- Include everything after this


vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.api.nvim_create_user_command('Bk',function() require('dap').toggle_breakpoint() end, {})
vim.api.nvim_create_user_command('DapRepeat',function() require('dap').run_last() end, {})
vim.api.nvim_create_user_command('DapOpen',function() dapui.open() end, {})
vim.api.nvim_create_user_command('DapClose',function() dapui.close() end, {})
