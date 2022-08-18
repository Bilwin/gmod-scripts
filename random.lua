local random = {
    _VERSION    = 1.1,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/random.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

function random:generate(len)
    len = len or math.random(32)
    local str = ''

    for i = 1, len do
        str = str .. (math.random() > .5 and (math.random() > .5 
        and string.char(math.random(65, 90))
        or string.char(math.random(97, 122))) or string.char(math.random(48, 57)))
    end

    return str
end

return random