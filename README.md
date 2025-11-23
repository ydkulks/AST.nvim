<h1 align="center"> AST.nvim </h1>

<p align="center">AST implementation for neovim text editor.</p>

## Motivation
- Abstract Syntax Tree (AST), is a tree that represents the code in an abstract way, which will
help you understand the code better.
- Especially when you are working on someone else's codebase
- It's also helpful to move around in a file quickly

## Demo
<div align="center">

![](https://github.com/ydkulks/AST.nvim/assets/56758248/04a223fa-ed67-45d8-8d60-aa57cdca7481)
</div>

## Requirements

- Install [NerdFont](https://www.nerdfonts.com/) for displaying icons in right format.
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) plugin
- [Plenary](https://github.com/nvim-lua/plenary.nvim) plugin

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

### Toggle window

Type `:ASTToggle` in vim command-line to toggle the window

### Jumping
- Toggle the window
- Navigate to the node which you would like to jump to and hit enter
- Hit enter key

### Exiting window

1. Go to a node to jump to that coordinate. This will close window before jumping.
2. Hit `q` in `Normal` mode when the window is open

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

The vim command `:ASTToggle` will toggle the pop-up. Map this command to some keys to toggle the window.
```lua
-- For example:
-- Mapped <leader>t to toggle the pop-up window
vim.keymap.set("n","<leader>t",":ASTToggle<CR>")
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
