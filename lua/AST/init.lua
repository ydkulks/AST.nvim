local M = {}
local vim = vim
local defaults = require("AST.config")
local UI = require("AST.UI")
-- If user did not setup config, use defaults
M.config = defaults

M.setup = function(update)
  -- replace defaults with user config
  M.config = vim.tbl_deep_extend('force', defaults, update)
end

M.toggle = function()
  UI.toggle_window(M.config)
end

return M
