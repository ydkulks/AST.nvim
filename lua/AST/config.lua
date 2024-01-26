local M = {}
-- Default config
M.nodeTypeRequired = {
  javascript = {
    -- { "function_declaration", "󰡱 " },
    { "function_definition", "󰡱 " },
    { "arrow_function", "󰡱 " },
    { "if_statement", " " },
    { "for_statement", " " },
    { "while_statement", " " }
  },
  lua = {
    { "function_declaration", "󰡱 " },
    { "function_definition", "󰡱 " },
    { "if_statement", " " },
    { "for_statement", " " },
    { "while_statement", " " }
  },
  generic = {
    { "function_definition", "󰡱 " },
    { "if_statement", " " },
    { "for_statement", " " },
    { "while_statement", " " }
  }
}

return M
