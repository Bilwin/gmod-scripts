return function(enums, existing_enumerator)
    if type(enums) ~= 'string' or enums:len() == 0 then return end

    local words = enums:upper():gsub('\n', ' '):split ' '
    local first_valid_word = nil
    local enumerator = 1

	if existing_enumerator then
		enumerator = enumerators[existing_enumerator] or 1
	end

	for _, word in ipairs(words) do
		if word ~= '' and word ~= ' ' then
			if not first_valid_word then
			    first_valid_word = word
			end

			_G[word] = enumerator
			enumerator = enumerator + 1
		end
	end

	if enumerator > 0 then
		local idx = first_valid_word:match('^([%w0-9]+)')

		if idx then
			enumerators[idx] = enumerator - 1
		end
	end

    return enumerator - 1
end