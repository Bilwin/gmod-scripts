local safe = {
    _VERSION    = 1.0,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/safe.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

function safe:html(str)
    return str:gsub('&', '&amp;'):gsub('<', '&lt;'):gsub('>', '&gt;')
end

function safe:steam_id(str)
    return str:gsub('[^%w:_]', '') || ''
end

function safe:explode_quotes(str)
	str = ' ' .. str .. ' '
	local res = {}
	local ind = 1
	while true do
		local sInd, start = str:find('[^%s]', ind)
		if not sInd then break end
		ind = sInd + 1
		local quoted = str:sub(sInd, sInd):match('["\']') && true || false
		local fInd, finish = str:find(quoted && '["\']' || '[%s]', ind)
		if not fInd then break end
		ind = fInd + 1
		local str = str:sub(quoted && sInd + 1 || sInd, fInd - 1)
		res[#res + 1] = str
	end
	return res
end

return safe