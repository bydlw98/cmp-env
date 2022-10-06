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

	for key, value in pairs(env_vars) do
		-- Prepend $ to key, also surround in braces if `show_braces` is true
		-- e.g. PATH -> $PATH -> ${PATH}
		key = "$" .. (opts.show_braces and "{" .. key .. "}" or key)

		table.insert(completion_items, {
			label = key,
			-- Evaluate the environment variable if `eval_on_confirm` is true
			insertText = opts.eval_on_confirm and value or key,
			word = key,
			-- Show documentation if `show_documentation_window` is true
			documentation = opts.show_documentation_window and
				setup_documentation_for_item(key, value),
			kind = opts.item_kind,
		})
	end
end

return function(self, params, callback)
	-- When first ran, cached_results will be false
	-- thus setup completion_items so that it does not have to be setup again
	-- After the first time, there is no need to setup completion_items again
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
