local cmp = require("cmp")

local M = {}

M.default_options = {
	show_documentation_window = true,
	item_kind = cmp.lsp.CompletionItemKind.Variable,
}

M.validate_options = function(params)
	local options = vim.tbl_deep_extend("keep", params.option, M.default_options)
	vim.validate({
		show_documentation_window = { options.show_documentation_window, "boolean" },
		item_kind = { options.item_kind, "number" },
	})
	return options
end

return M
