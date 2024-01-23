local M = {}
require("AST.config")
local ts_utils = require("nvim-treesitter.ts_utils")

M.setup = function(update)
  print(update)
end

local function getRootNode()
  local node = ts_utils.get_node_at_cursor()
  if node == nil then
    error("No Treesitter parser found.")
  end
  return node:root()
end

-- BFS traversal function
local function bfsTraversal(root)
  if not root then
    print("Error: Root node is nil.")
    return
  end

  local queue = { root }

  while #queue > 0 do
    local current_node = table.remove(queue, 1)

    -- Check if the current node has children
    if current_node:named_child_count() > 0 then
      -- Print information about the current node
      -- print("Node type:", current_node:type())

      -- Get function_declaration node
      if current_node:type() == "function_declaration" then
        -- Print information about the function node
        local row, col, _ = current_node:start()
        row = row + 1
        col = col + 1
        print("Function identifier: " .. row, col)
      end

      -- Get if_statement node
      if current_node:type() == "if_statement" then
        -- Print information about the if_statement node
        local row, col, _ = current_node:start()
        row = row + 1
        col = col + 1
        print("If condition: " .. row, col)
      end

      -- Enqueue all children for further processing
      local named_children = current_node:named_children()
      for _, child in ipairs(named_children) do
        table.insert(queue, child)
      end
    end
  end
end

M.test = function()
  -- local bufnr = vim.api.nvim_get_current_buf()
  local root_node = getRootNode()
  bfsTraversal(root_node)
end

return M
