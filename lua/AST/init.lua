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

M.toggle = function()
  -- if buffer.filetype == userConfig.key, use : key.value
  local bufnr = vim.fn.bufnr()
  local bufferFileType = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local buffConfig = M.config.nodeTypeRequired[bufferFileType] or M.config.nodeTypeRequired.generic
  return UI.toggle_window(buffConfig)
end

return M
