local M = {}
M.results = {}

local function checkNodeType(node, nodeType_Icon)
  for i, nodeType in pairs(nodeType_Icon) do
    if node:type() == nodeType then
      local row, col, _ = node:start()
      row = row + 1
      col = col + 1
      if row ~= nil and col ~= nil then
        table.insert(M.results, { icon = nodeType_Icon[i+1], type = nodeType, row = row, col = col })
      end
    end
  end
end

-- BFS traversal function
M.bfsTraversal = function(root, nodeTypeRequired)
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
      for _, value in ipairs(nodeTypeRequired) do
        checkNodeType(current_node, value)
      end

      -- Enqueue all children for further processing
      local named_children = current_node:named_children()
      for _, child in ipairs(named_children) do
        table.insert(queue, child)
      end
    end
  end
end

-- DFS traversal function
M.dfsTraversal = function(node, nodeTypeRequired)
  if not node then
    return
  end

  for _, value in ipairs(nodeTypeRequired) do
    checkNodeType(node, value)
  end

  -- Recursively visit all named children
  local named_children = node:named_children()
  for _, child in ipairs(named_children) do
    M.dfsTraversal(child, nodeTypeRequired)
  end
end

return M
