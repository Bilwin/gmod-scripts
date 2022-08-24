local function generate()
	return string.gsub('xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx', '[xy]', function(c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
		return ('%x'):format(v)
    end)
end

local cache = {}
local function unique()
	local uuid
	repeat
		uuid = self:generate()
	until not cache[uuid]
	cache[uuid] = true
	return uuid
end

return function(unique)
	return unique and unique() or generate()
end