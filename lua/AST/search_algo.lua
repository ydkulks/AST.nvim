local M = {}
M.results = {}

local function getNodeName(node)
  -- Try to find an identifier child node
  for child in node:iter_children() do
    if child:type() == "identifier" or child:type() == "name" then
      local start_row, start_col, end_row, end_col = child:range()
      if start_row == end_row then -- single line
        local line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]
        if line then
          return line:sub(start_col + 1, end_col)
        end
      end
    end
  end

  -- For some node types, use a default name
  local node_type = node:type()
  if node_type == "if_statement" then
    return "if"
  elseif node_type == "for_statement" then
    return "for"
  elseif node_type == "while_statement" then
    return "while"
  elseif node_type == "function_definition" or node_type == "function_declaration" then
    return "function"
  elseif node_type == "atx_heading" then
    -- For markdown headings, try to get the heading text
    for child in node:iter_children() do
      if child:type() == "inline" then
        local start_row, start_col, end_row, end_col = child:range()
        if start_row == end_row then
          local line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]
          if line then
            return line:sub(start_col + 1, end_col)
          end
        end
      end
    end
    return "heading"
  elseif node_type == "list" then
    return "list"
  elseif node_type == "fenced_code_block" then
    return "code"
  elseif node_type == "package_clause" then
    return "package"
  elseif node_type == "import_declaration" then
    return "import"
  elseif node_type == "func_literal" then
    return "func"
  end

  -- Fallback to node type if no name found
  return node_type
end

local function checkNodeType(node, nodeType_Icon)
  for i, nodeType in pairs(nodeType_Icon) do
    if node:type() == nodeType then
      local row, col, _ = node:start()
      row = row + 1
      col = col + 1
      if row ~= nil and col ~= nil then
        local line_content = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
        local indentation = string.match(line_content, '^%s*') or '' -- Extract leading whitespace
        local indent_level = string.len(indentation)
        local node_name = getNodeName(node)
        table.insert(M.results, {
          icon = nodeType_Icon[i + 1],
          type = nodeType,
          name = node_name,
          row = row,
          col = col,
          indent = indent_level
        })
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
