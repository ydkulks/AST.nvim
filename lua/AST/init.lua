local M = {}
require("AST.theme")
local vim = vim
local defaults = require("AST.config")
local UI = require("AST.UI")
-- If user did not setup config, use defaults
M.config = defaults

M.setup = function(update)
   -- replace defaults with user config
   M.config = vim.tbl_deep_extend('force', defaults, update)
end

-- Create commands
vim.api.nvim_create_user_command('ASTToggle', function()
  M.toggle()
end, {})

vim.api.nvim_create_user_command('ASTSearch', function()
  M.search()
end, {})

M.toggle = function()
  -- Pass the full config to UI.toggle_window so it can access displayNodeNames
  return UI.toggle_window(M.config)
end

M.search = function()
  return require("AST.UI").search(M.config)
end

return M
