local M = {}
local vim = vim
local ts_utils = require("nvim-treesitter.ts_utils")
local algo = require("AST.search_algo")
local defaults = require("AST.config")
-- If user did not setup config, use defaults
M.config = defaults

M.setup = function(update)
  -- replace defaults with user config
  M.config = vim.tbl_deep_extend('force',defaults,update)
end

local function getRootNode()
  local node = ts_utils.get_node_at_cursor()
  if node == nil then
    error("No Treesitter parser found.")
  end
  return node:root()
end

M.test = function()
  -- local bufnr = vim.api.nvim_get_current_buf()
  local root_node = getRootNode()
  -- algo.bfsTraversal(root_node, M.config.nodeTypeRequired)
  algo.dfsTraversal(root_node, M.config.nodeTypeRequired)
  vim.print(algo.results)
  -- reset result's value
  algo.results = {}
end

M.showPopup = function ()
  require("AST.UI")
end

return M
