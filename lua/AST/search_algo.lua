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
