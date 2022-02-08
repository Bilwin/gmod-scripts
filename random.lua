local random = {
    _VERSION    = 1.0,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/random.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

function random:generate(len)
    len = tonumber(len) || 10
    local str = ''

    for i = 1, len do
        str = str .. (math.random() > .5 && (math.random() > .5 
        && string.char(math.random(65, 90))
        || string.char(math.random(97, 122))) || string.char(math.random(48, 57)))
    end

    return str
end

return random