local dump = {
    _VERSION    = 1.0,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/dump.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

local _DUMPER = {__index = _DUMPER}
function dump:register()
    local _DUMP = {}
    self.dump[#self.dump + 1] = _DUMPER
    setmetatable(_DUMPER, _DUMP)
    return _DUMPER
end

function _DUMPER:st_table() self.stored = {} end
function _DUMPER:add_value(value)
    self.stored[#self.stored + 1] = value
    return self
end

function _DUMPER:get_value(index) return self.stored[index] end
function _DUMPER:override_value(index, value)
    self.stored[index] = value
    return self
end

function _DUMPER:get_st() return self.stored end
function _DUMPER:wipe() self.stored = nil end

function _DUMPER:execute(index, ...)
    if isfunction(self.stored[index]) then
        self.stored[index](...)
    else
        error(Format('%s is not a function!', self.id))
    end
end

return dump