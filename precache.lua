local precache = {
    _VERSION    = 1.1,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/precache.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

precache.mdl        = precache.mdl or {}
precache.materials  = precache.materials or {}
precache.sounds     = precache.sounds or {}

function precache:add_mdl(path)
    if #self.mdl >= 4096 then return end
    self.mdl[#self.mdl + 1] = path
end

function precache:add_sound(path)
    if #self.sounds >= 16384 then return end
    self.sounds[#self.sounds + 1] = path
end

function precache:execute()
    for _, v in ipairs(self.mdl) do
        util.PrecacheModel(v)
    end

    for _, v in ipairs(self.sounds) do
        util.PrecacheSound(v)
    end
end

local oMaterial = oMaterial or Material
function Material(materialName, pngParams)
    if not precache.materials[materialName] then
        pngParams = pngParams or 'nil'
        precache.materials[materialName] = oMaterial(materialName, pngParams)
    end

    return precache.materials[materialName]
end

return precache
