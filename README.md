<h1 align="center"> AST.nvim </h1>

<p align="center">AST implementation for neovim text editor.</p>

## Motivation
- Abstract Syntax Tree (AST), is a tree that represents the code in an abstract way, which will
help you understand the code better.
- Especially when you are working on someone else's codebase
- It's also helpful to move around in a file quickly

## Demo

### Telescope

<div align="center">

![Telescope search with preview](https://github.com/user-attachments/assets/140c3d09-3855-4834-bebc-89f4b94ecf43)

</div>

### Plenary popup

<div align="center">

![Popup](https://github.com/user-attachments/assets/6eec6ef7-0196-48d4-b5cb-8f1602c5bcb5)

</div>

### Quick Fix List (Fallback)

<div align="center">

![Quick fix list](https://github.com/user-attachments/assets/e28a6d3c-e9bc-49f2-9bed-bdcef1644369)

</div>

## Requirements

- Install [NerdFont](https://www.nerdfonts.com/) for displaying icons in right format.
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) plugin
- [Plenary](https://github.com/nvim-lua/plenary.nvim) plugin (optional, for popup UI)
- (Optional) [Telescope](https://github.com/nvim-telescope/telescope.nvim) for enhanced search

## Quick Start
Using your favorite plugin manager, install this plugin with its dependencies.

Here is an example for packer package manager.
```lua
use{
  "ydkulks/AST.nvim",
  requires = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require("AST")
  end
}
```

## Usage

### Toggle AST Window

Type `:ASTToggle` in vim command-line to open the AST window. If Plenary is available, it opens a popup window; otherwise, it falls back to the quickfix list.

#### Popup Mode (with Plenary)
- Navigate to the node you want to jump to and press `<CR>`
- Press `q` to close the window

#### Quickfix Mode (fallback)
- Navigate to the node you want to jump to and press `<CR>`
- This jumps to the code location and closes the quickfix window
- Use `:cclose` to close without jumping

### Search AST Nodes

Type `:ASTSearch` to populate the quickfix list and open Telescope's fuzzy search (if available) or the standard quickfix window.

- Use Telescope's search to filter and select nodes
- Press `<CR>` to jump to the selected node

## Defaults

You can view the defaults [here](https://github.com/ydkulks/AST.nvim/blob/0b8189c9cea41e3842a2fe01558b10adba3d4289/lua/AST/config.lua#L3) 
and customize them according to your needs

## Customization

The plugin can be configured using the `setup()` function. Available options:

- `displayNodeNames`: `true` to show node names (e.g., function names), `false` to show node types (default: `true`)
- `nodeTypeRequired`: Buffer type (key) and a table of nodes and their icons

Example configuration:
```lua
require("AST").setup({
  displayNodeNames = true,
  nodeTypeRequired = {
    rust = {
      { "function_declaration", "󰡱 " },
      { "if_statement", " " },
      { "for_statement", " " },
      { "while_statement", " " }
    }
  }
})
```
> Note: You can get the node type value from inspecting the buffer using `:InspectTree` or by installing
> treesitter's playground plugin.

## User Mappings

Map the commands to keys for quick access.
```lua
-- For example:
-- Mapped <leader>t to toggle the AST window
vim.keymap.set("n","<leader>t",":ASTToggle<CR>")
-- Mapped <leader>s to search AST nodes
vim.keymap.set("n","<leader>s",":ASTSearch<CR>")
```

## Highlight Groups

In this [file](https://github.com/ydkulks/AST.nvim/blob/0b8189c9cea41e3842a2fe01558b10adba3d4289/lua/AST/theme.lua#L3), 
some `highlight groups` have been created. Which can be changed in your configuration.

```lua
-- Here is an example to configure highlight groups
vim.api.nvim_set_hl(0, 'ASTIcon', { fg = "#98C379", ctermfg = 114 })
```

## Contribute

- Submissions are welcome. Just open a pull-request under a branch named after your name.
- DO NOT MAKE CHANGES TO MAIN BRANCH
- If you find a bug, please create an issue.
