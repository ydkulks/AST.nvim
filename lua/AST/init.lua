local M = {}
local vim = vim
require("AST.config")
local ts_utils = require("nvim-treesitter.ts_utils")

M.setup = function (update)
  print(update)
end

local function getRootNode()
  local node = ts_utils.get_node_at_cursor()
  if node == nil then
    error("No Treesitter parser found.")
  end
  local root_node = node:root()
  -- local parent_node = node:parent()
  -- local child_node = node:next_sibling()
  return root_node
end

M.test= function (index)
  local root_node = getRootNode()
  if index == nil then
    index = 0
  end
  local bufnr = vim.api.nvim_get_current_buf()
  ts_utils.update_selection(bufnr,root_node:named_child(index))
  -- local child = ts_utils.get_named_children(root_node)
  -- print(vim.inspect(child))
end

return M
