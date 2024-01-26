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
  -- if buffer.filetype == userConfig.key, use : key.value
  local bufnr = vim.fn.bufnr()
  local bufferFileType = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  for fileType, config in pairs(M.config.nodeTypeRequired) do
    if fileType == bufferFileType then
      return UI.toggle_window(config)
    else
      local generic = M.config.nodeTypeRequired.generic
      return UI.toggle_window(generic)
    end
  end
end

return M
