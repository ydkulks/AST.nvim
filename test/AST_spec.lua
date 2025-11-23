local describe = describe
local it = it
local vim = vim

describe("AST", function()
  it("can be required", function()
    require("nvim-treesitter.ts_utils")
    -- require("AST")
  end)

  it("can get manual", function()
    vim.cmd("h AST.txt")
  end)

  it("can use config", function()
    require("AST.config")
  end)

  it("can use setup", function()
    require("AST").setup({
      nodeTypeRequired = {
        "function_declaration",
        "if_statement",
        "for_statement",
        "while_statement"
      }
    })
  end)

  it("can configure displayNodeNames", function()
    require("AST").setup({
      displayNodeNames = false
    })
    assert.are.equal(require("AST").config.displayNodeNames, false)

    require("AST").setup({
      displayNodeNames = true
    })
    assert.are.equal(require("AST").config.displayNodeNames, true)
  end)

  it("Other test", function()
    local M = {}
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
        -- { "arrow_function", "󰡱 " },
        { "if_statement", " " },
        { "for_statement", " " },
        { "while_statement", " " }
      },
    }
    for fileType, config in pairs(M.nodeTypeRequired) do
      print(fileType)
      for _, type_and_icon in pairs(config) do
        local nodeType = type_and_icon[1]
        local nodeIcon = type_and_icon[2]
        print(nodeIcon, nodeType)
      end
    end
    return M
  end)
end)
