local steamhttp = {
    _VERSION    = 1.0,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/steamhttp.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

function steamhttp:get_group_members(group_name, cb)
    local data = {}
    HTTP({
        url = 'http://steamcommunity.com/groups/'..group_name..'/memberslistxml/?xml=1',
        method = 'get',
        headers = {},
        success = function(code, body, header)
            if not body then error('Unknown steamhttp:get_group_members body! Code ' .. code) end
            body = body:Split('\n')

            for _, value in ipairs(body) do
                if value:find('<steamID64>') then
                    table.insert(data, string.Replace(value:match'%d+<', '<', ''))
                end
            end

            cb(data)
        end,
        failed = function(err)
            error('HTTP Request Failed, steamhttp:get_group_members -> ' .. err)
        end
    })
end

function steamhttp:vac_banned(steamid64, cb)
    local status = false
    HTTP({
        url = 'https://steamcommunity.com/profiles/'..steamid64..'/?xml=1',
        method = 'get',
        headers = {},
        success = function(code, body, header)
            if not body then error('Unknown steamhttp:vac_banned body! Code ' .. code) end
            body = body:Split('\n')

            for _, value in ipairs(body) do
                if value:find('<vacBanned>1') then
                    status = true
                    break
                end
            end

            cb(status)
        end,
        failed = function(err)
            error('HTTP Request Failed, steamhttp:vac_banned -> ' .. err)
        end
    })
end

function steamhttp:get_profile_key(steamid64, key, cb)
    HTTP({
        url = 'https://steamcommunity.com/profiles/'..steamid64..'/?xml=1',
        method = 'get',
        headers = {},
        success = function(code, body, header)
            if not body then error('Unknown steamhttp:get_profile_key body! Code ' .. code) end
            body = body:Split('\n')
            local data

            for _, v in ipairs(body) do
                if v:find(key) then
                    data = v
                    break
                end
            end

            cb(data)
        end,
        failed = function(err)
            error('HTTP Request Failed, steamhttp:get_profile_key -> ' .. err)
        end
    })
end

return steamhttp