local source = {}

source.new = function()
	return setmetatable({}, { __index = source })
end

source.get_trigger_characters = function()
	return { "$" }
end

source.complete = require("cmp-env.complete")

return source
