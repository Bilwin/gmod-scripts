local precache = {
    _VERSION    = 1.0,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/precache.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

precache.mdl = precache.mdl || {}
precache.materials = precache.materials || {}
precache.sounds = precache.sounds || {}

function precache:add_mdl(path)
    if #self.mdl >= 4096 then error('max caching models! ~4096') return end
    self.mdl[#self.mdl + 1] = path
end

function precache:add_sound(path)
    if #self.sounds >= 16384 then error('max caching sounds! ~16384') return end
    self.sounds[#self.sounds + 1] = path
end

function precache:execute()
    print('Caching...')

    for _, v in ipairs(self.mdl) do
        util.PrecacheModel(v)
        print(Format('Cached \'%s\' model', v))
    end

    for _, v in ipairs(self.sounds) do
        util.PrecacheSound(v)
        print(Format('Cached \'%s\' sound', v))
    end

    print 'Successfully cached models and sounds!'
    print 'If you have issues like broken models, run `r_flushlod` command to checksum it again.'
end

-- [Material] override
local oldMaterial = oldMaterial || Material
function Material(materialName, pngParams)
    if not self.materials[materialName] then
        pngParams = pngParams || 'nil'
        self.materials[materialName] = oldMaterial(materialName, pngParams)
    end
    return self.materials[materialName]
end

return precache