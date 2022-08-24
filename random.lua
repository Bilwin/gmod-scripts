return function(len)
    len = len or math.random(32)
    local str = ''

    for i = 1, len do
        str = str .. (math.random() > .5 and (math.random() > .5 
        and string.char(math.random(65, 90))
        or string.char(math.random(97, 122))) or string.char(math.random(48, 57)))
    end

    return str
end