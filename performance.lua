local performance = {
    _VERSION    = 1.0,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/performance.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

local _PERFORMANCE = {__index = _PERFORMANCE}
function performance:register()
    local _PERF = {}
    setmetatable(_PERFORMANCE, _PERF)
    return _PERFORMANCE
end

function _PERFORMANCE:st_table()
    self.stored = {}
    return self
end

function _PERFORMANCE:add_func(func)
    assert(isfunction(func), 'Invalid :add_func argument! Argument: '..type(func))
    self.stored[#self.stored + 1] = func
    return self
end

function _PERFORMANCE:execute()
    self.results = {}

    for index, func in ipairs(self.stored) do
        self.results[index] = {}
        self.results[index].startTime = os.clock()
        func()
        self.results[index].endTime = os.clock()
    end

    for index, value in ipairs(self.results) do
        print(Format('Index: %s; Speed: %.10f', index, value.endTime - value.startTime))
    end
end
