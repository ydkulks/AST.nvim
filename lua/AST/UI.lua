local M = {}
local vim = vim
local window_state = false
local popup = require("plenary.popup")
local algo = require("AST.search_algo")
local buffer = 0
local cursor_pos = { 0, 0 }

local function getRootNode()
  local bufnr = vim.fn.bufnr()
  return vim.treesitter.get_parser(bufnr):parse()[1]:root()
end

local function parseResult(results)
  local parsedResults = {}

  for _, value in ipairs(results) do
    local indentation = ""
    for _ = 1, value.col - 1, 1 do
      indentation = indentation .. " "
    end

    local parsedResult = string.format("%s%s%s [ %d:%d ]", indentation, value.icon, value.type, value.row, value.col)
    table.insert(parsedResults, parsedResult)
  end

  return parsedResults
end

local function colorScheme()
  local hl_brackets = "Comment"
  local hl_icon = "Special"

  for line_num = 1, vim.api.nvim_buf_line_count(0) do
    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]

    -- Highlighting brackets
    local start_col_brackets, end_col_brackets = string.find(line, "%[.*%]")
    if start_col_brackets and end_col_brackets then
      vim.api.nvim_buf_add_highlight(0, -1, hl_brackets, line_num - 1, start_col_brackets - 1, end_col_brackets)
    end

    -- Highlighting icon at the beginning of the line
    local start_col_icon, end_col_icon = string.find(line, "^%s*%S+")
    if start_col_icon and end_col_icon then
      vim.api.nvim_buf_add_highlight(0, -1, hl_icon, line_num - 1, start_col_icon - 1, end_col_icon)
    end
  end
end

local function create_window(results)
  local content = parseResult(results)
  local width = 70
  local height = 20
  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
  buffer = popup.create(content, {
    title = "AST",
    highlight = "HarpoonWindow",
    padding = { 0, 1, 0, 0 },
    minwidth = 50,
    maxwidth = width,
    minheight = 5,
    maxheight = height,
    borderchars = borderchars,
  })

  colorScheme()
  -- Remember cursor position and jump to it
  local row = cursor_pos[1]
  local col = cursor_pos[2]
  vim.cmd(string.format('normal! %dgg%d|', row, col))
end

function M.toggle_window(config)
  if window_state then
    M.close_window()
  else
    local root_node = getRootNode()

    -- Travarse through treesitter and append nodes to "results" table
    algo.dfsTraversal(root_node, config.nodeTypeRequired)

    create_window(algo.results)

    -- change state and reset value
    window_state = true
    algo.results = {}

    -- Keymaps
    vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', "<cmd>lua require'AST.UI'.goto_line()<CR>",
      { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'q', "<cmd>lua require'AST.UI'.close_window()<CR>",
      { noremap = true, silent = true })
    -- Buffer options
    vim.api.nvim_win_set_option(0, 'number', true)
    vim.api.nvim_win_set_option(0, 'relativenumber', true)
    vim.api.nvim_win_set_option(0, 'cursorline', true)
    vim.api.nvim_buf_set_option(0, 'filetype', 'AST')
  end
end

function M.goto_line()
  -- Get cursor position and its line value
  cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line_value = vim.api.nvim_buf_get_lines(0, cursor_pos[1] - 1, cursor_pos[1], false)[1]

  -- Extract row and column values from the end of the line
  local row, col = line_value:match("%[ (%d+):(%d+) %]")
  if row and col then
    row = tonumber(row)
    col = tonumber(col)
    M.close_window()
    vim.cmd(string.format('normal! %dgg%d|', row, col))
  else
    M.close_window()
  end
end

function M.close_window()
  vim.api.nvim_win_close(buffer, true)
  -- Change state
  window_state = false
end

return M
