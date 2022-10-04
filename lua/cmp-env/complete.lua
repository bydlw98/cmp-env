local cmp = require("cmp")
local options = require("cmp-env.options")

local cached_results = false

local completion_items = {}

local function setup_documentation_for_item(key, value)
	return {
		kind = "markdown",
		value = "```sh\n" .. value .. "\n```",
	}
end

local function setup_completion_items(params)
	-- Get option from cmp.setup of cmp-env
	local opts = options.validate_options(params)

	-- Get a dictionary with environment variables and their respective values
	local env_vars = vim.fn.environ()

	-- Set default item_kind as cmp.lsp.CompletionItemKind.Variable
	local item_kind = cmp.lsp.CompletionItemKind.Variable

	-- If item_kind option is set, use the value set
	-- else use default value of cmp.lsp.CompletionItemKind.Variable
	if opts.item_kind ~= item_kind then
		item_kind = opts.item_kind
	end

	for key, value in pairs(env_vars) do
		-- Prepend $ to key.
		-- eg. PATH -> $PATH
		key = "$" .. key

		table.insert(completion_items, {
			label = key,
			-- Evaluate the environment variable if `eval_on_confirm` is true
			insertText = opts.eval_on_confirm and value or key,
			word = key,
			-- Show documentation if `show_documentation_window` is true
			documentation = opts.show_documentation_window and
				setup_documentation_for_item(key, value),
			kind = item_kind,
		})
	end
end

return function(self, params, callback)
	-- When first runned, cached_results will be false
	-- thus setup completion_items so that it does not have to be setup again
	-- After the first time, there is no need to setup completion_items agains
	-- as the environments variables would unlikely be changed and the cached
	-- completion_items is reused
	if cached_results == false then
		setup_completion_items(params)
		cached_results = true
		-- print(vim.inspect(completion_items))
		callback(completion_items)
	else
		callback(completion_items)
	end
end
