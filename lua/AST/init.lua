local M = {}
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
  return node:root()
end

local function VisitNode(node)
  for child, _ in ipairs(node) do
    -- print(node[child])
    -- Get function_declaration node
    if node[child]:type() == "function_declaration" then
      -- need a function to display function node
      local row, col, _ = node[child]:named_child(0):start()
      row = row + 1
      col = col + 1
      print("Function identifier: " .. row, col)
    end
    -- Get if_statement node
    if node[child]:type() == "if_statement" then
      local row, col, _ = node[child]:start()
      row = row + 1
      col = col + 1
      print("If condition: " .. row, col)
    end

    -- Attempt to get named children
    local success, _ = pcall(function() return node:named_children() end)
    if success then
      -- local children = ts_utils.get_named_children(node)
      local children = node.named_children()
      for _, grandChild in ipairs(children) do
        VisitNode(grandChild)
      end
    else
      -- If an error occurs, print a message and exit the loop
      -- print("Error:", _)
      print("Error")
      -- return
    end

  end
end

M.test= function ()
  -- local bufnr = vim.api.nvim_get_current_buf()
  local root_node = getRootNode()
  local children = ts_utils.get_named_children(root_node)
  VisitNode(children)
end

return M
