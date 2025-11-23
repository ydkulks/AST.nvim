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
  typescriptreact = {
    -- Functions
    { "function_declaration", "󰡱 " },
    { "arrow_function", "󰡱 " },
    { "method_definition", "󰡱 " },

    -- Classes and Types
    { "class_declaration", " " },
    { "interface_declaration", " " },
    { "type_alias_declaration", " " },
    { "enum_declaration", " " },

    -- React Components
    { "function_component_declaration", "󰡱 " },
    { "class_component_declaration", " " },

    -- JSX Elements
    { "jsx_element", "󰜈 " },
    { "jsx_self_closing_element", "󰜈 " },

    -- Control Flow
    { "if_statement", " " },
    { "for_statement", " " },
    { "while_statement", " " },
    { "switch_statement", "󰒉 " },

    -- Imports/Exports
    { "import_statement", "󰋺 " },
    { "export_statement", "󰋺 " },

    -- Variable declarations
    { "variable_declaration", "󰀫 " },
    { "lexical_declaration", "󰀫 " },
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
