local M = {}
-- Default config
M.displayNodeNames = true -- true: show node names, false: show node types
M.nodeTypeRequired = {
  javascript = {
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
  markdown = {
    { "atx_heading", " " },
    { "list", " " },
    { "fenced_code_block", " " },
  },
  go = {
    {"package_clause"," "},
    {"import_declaration","󰋺 "},
    {"function_declaration","󰡱 "},
    {"func_literal","󰡱 "},
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
