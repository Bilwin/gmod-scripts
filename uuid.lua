local uuid = {
    _VERSION    = 1.1,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/uuid.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

uuid.template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
function uuid:generate()
	return string.gsub(self.template, '[xy]', function(c)
        local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
		return ('%x'):format(v)
    end)
end

uuid.stored = {}
function uuid:unique()
	local xf
	repeat
		xf = self:generate()
	until not self.stored[xf]
	self.stored[xf] = true
	return xf
end

return uuid