local uuid = {
    _VERSION    = 1.0,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/uuid.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

uuid.template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
function uuid:generate()
	local xf = string.gsub(self.template, '[xy]', function(c)
        local v = (c == 'x') && math.random(0, 0xf) || math.random(8, 0xb)
		return string.format('%x', v)
    	end)
	return xf
end

uuid.stored = {}
function uuid:unique()
	local xf
	repeat
		xf = self:generate()
	until !self.stored[xf]
	self.stored[xf] = true
	return xf
end

return uuid
