local vim = vim
-- Create highlight group
vim.api.nvim_set_hl(0, 'ASTWindow', {})
vim.api.nvim_set_hl(0, 'ASTCoordinates', { link = 'Comment' })
-- vim.api.nvim_set_hl(0, 'ASTIcon', { fg = "#98C379", ctermfg = 114 })
vim.api.nvim_set_hl(0, 'ASTIcon', { link = 'WarningMsg'})
