local M = {}
require("AST.theme")
local vim = vim
local defaults = require("AST.config")
local UI = require("AST.UI")
-- If user did not setup config, use defaults
M.config = defaults

M.setup = function(update)
  -- replace defaults with user config
  M.config = vim.tbl_deep_extend('force', defaults, update)
end

M.toggle = function()
  -- if buffer.filetype == userConfig.key, use : key.value
  local bufnr = vim.fn.bufnr()
  local bufferFileType = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local buffConfig = M.config.nodeTypeRequired[bufferFileType] or M.config.nodeTypeRequired.generic
  return UI.toggle_window(buffConfig)
end

M.nodeJump = function()
  local ts_utils = require("nvim-treesitter.ts_utils")

  -- local current_node = ts_utils.get_node_at_cursor(0)
  -- ts_utils.update_selection(0, cursor_node)

  -- Keymaps
  vim.api.nvim_set_keymap('n', '<Up>', ':lua require("AST").prev_node()<CR>', {
    noremap = true, silent = true
  })
  vim.api.nvim_set_keymap('n', '<Down>', ':lua require("AST").next_node()<CR>', {
    noremap = true, silent = true
  })
  vim.api.nvim_set_keymap('n', '<Right>', ':lua require("AST").child_node()<CR>', {
    noremap = true, silent = true
  })
  vim.api.nvim_set_keymap('n', '<Left>', ':lua require("AST").parent_node()<CR>', {
    noremap = true, silent = true
  })
  vim.api.nvim_set_keymap('v', '<Up>', ':lua require("AST").prev_node()<CR>', {
    noremap = true, silent = true
  })
  vim.api.nvim_set_keymap('v', '<Down>', ':lua require("AST").next_node()<CR>', {
    noremap = true, silent = true
  })
  vim.api.nvim_set_keymap('v', '<Right>', ':lua require("AST").child_node()<CR>', {
    noremap = true, silent = true
  })
  vim.api.nvim_set_keymap('v', '<Left>', ':lua require("AST").parent_node()<CR>', {
    noremap = true, silent = true
  })

  M.prev_node = function()
    local cursor_node = ts_utils.get_node_at_cursor(0)
    local prev = ts_utils.get_previous_node(cursor_node)
    if prev == nil then
      return
    end
    ts_utils.update_selection(0, prev)
  end

  M.next_node = function()
    local cursor_node = ts_utils.get_node_at_cursor(0)
    local next = ts_utils.get_next_node(cursor_node)
    if next == nil then
      return
    end
    ts_utils.update_selection(0, next)
  end

  M.child_node = function()
    print("child")
    local cursor_node = ts_utils.get_node_at_cursor(0)
    -- local child = ts_utils.get_next_node(cursor_node)
    local child = cursor_node:child()
    if child == nil then
      return
    end
    ts_utils.update_selection(0, child)
  end

  M.parent_node = function()
    print("parent")
    local cursor_node = ts_utils.get_node_at_cursor(0)
    -- local parent = ts_utils.get_next_node(cursor_node)
    local parent = cursor_node:parent()
    if parent == nil then
      return
    end
    ts_utils.update_selection(0, parent)
  end
end

return M
