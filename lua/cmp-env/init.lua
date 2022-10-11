local source = {}

source.new = function()
	return setmetatable({}, { __index = source })
end

source.get_keyword_pattern = function()
	return "\\$[^[:blank:]]*"
end

source.complete = require("cmp-env.complete")

return source
