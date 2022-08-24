local function strip_comment(line)
    local startPos, endPos = line:find('[;#]')
    if startPos then line = line:sub(1, startPos - 1):Trim() end
    return line
end

local function strip_quotes(line)
    return line:gsub('[\"]', ''):Trim()
end

return function(file_name, from_game, _strip_quotes)
	local wasSuccess, value = pcall(file.Read, file_name, (from_game and 'GAME' or 'DATA'))

	if wasSuccess and value ~= nil then
		local exploded_data = string.Explode('\n', value)
		local output_table = {}
		local current_node = ''

		for _, v in pairs(exploded_data) do
			local line = strip_comment(v):gsub('\n', '')

			if line ~= '' then
				if _strip_quotes then line = strip_quotes(line) end

				if line:sub(1, 1) == '[' then
					local start_pos, endPos = line:find('%]')

					if start_pos then
						current_node = line:sub(2, start_pos - 1)

						if not output_table[current_node] then output_table[current_node] = {} end
					else
						return false
					end
				elseif current_node == '' then
					return false
				else
					local data = string.Explode('=', line)

					if #data > 1 then
						local key = data[1]
						local value = table.concat(data, '=', 2)

						if tonumber(value) then
							output_table[current_node][key] = tonumber(value)
						elseif value == 'true' or value == 'false' then
							output_table[current_node][key] = (value == 'true')
						else
							output_table[current_node][key] = value
						end
					end
				end
			end
		end

		return output_table
	end
end