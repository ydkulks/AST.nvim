# TODO

- [x] Go through Treesitter help doc
    - :h treesitter-node
    - :h nvim-treesitter-utils
- [x] Get position of functions
- [x] Get position of conditions
- [x] Get position of loops
- [x] Loop through all the child and sub-child nodes
- [x] Remember cursor position in pop-up buffer
- [x] UI
    - [x] Decision: Quick-fix-list or Pop-up buffer
        - [x] Pop-up buffer
    - [x] Add indentation based on `col` value
    - [x] Color scheme
    - [x] Icons
- [x] User configuration
    - [x] Add nodes based on language
    - [x] Config icons
    - [x] Color scheme config
- [x] Add more to default config
- [ ] indentation issue: base it on hierarchy and not `col`
- [ ] Documentation
    - [ ] README.md
    - [ ] AST.txt (vim help doc)
```text
Note: Install Nerdfont to view fonts
     󰡱 function [5:15]
        condition [row:col]
         loop [row:col]
     󰡱  function [row:col]
        󰡱  Function [row:col]
        󰡱  Function [row:col]
     󰡱  function [row:col]
          loop [row:col]

```
