# cmp-env

[`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp) source for environment variables.<br><br>

## Requirements

* [`nvim-lua/plenary.nvim`](https://github.com/nvim-lua/plenary.nvim)

## Setup

```lua
require("cmp").setup {
    sources = {
        { name = "env" }
    }
}
```

## Configuration

Below are the options available for this source. To set any of the options:

```lua
cmp.setup({
    sources = {
        {
            name = "env",
            option = {
                show_documentation_window = true,
                item_kind = cmp.lsp.CompletionItemKind.Variable
            },
        },
    },
})
```

### show_documentation_window (type: boolean)

_Default:_ `true`

Whether to show documentation window which contains value of environment variable selected.

### item_kind (type: number)

_Default:_ `cmp.lsp.CompletionItemKind.Variable`

[`CompletionItemKind`](https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/types/lsp.lua#L104) shown in completion menu.
