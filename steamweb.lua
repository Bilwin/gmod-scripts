local steamweb = {
    _VERSION    = 1.1,
    _URL        = 'https://github.com/Bilwin/gmod-scripts/blob/main/steamweb.lua',
    _LICENSE    = 'https://github.com/Bilwin/gmod-scripts/blob/main/LICENSE'
}

function steamweb:get_group_members(group_name, fn)
    HTTP({
        url = 'http://steamcommunity.com/groups/'..group_name..'/memberslistxml/?xml=1',
        method = 'get',
        headers = {},
        success = function(code, body, header)
            if not body then error('Invalid steamweb:get_group_members body! Code ' .. code) end
            body = body:Split('\n')

            local response = {}
            for _, value in ipairs(body) do
                if value:find('<steamID64>') then
                    response[#response + 1] = string.Replace(value:match'%d+<', '<', '')
                end
            end

            fn(response)
        end,
        failed = function(err)
            error('HTTP Request Failed, steamweb:get_group_members -> ' .. err)
        end
    })
end

function steamweb:vac_banned(steamid64, fn)
    HTTP({
        url = 'https://steamcommunity.com/profiles/'..steamid64..'/?xml=1',
        method = 'get',
        headers = {},
        success = function(code, body, header)
            if not body then error('Invalid steamweb:vac_banned body! Code ' .. code) end
            body = body:Split('\n')

            local response = false
            for _, value in ipairs(body) do
                if value:find('<vacBanned>1') then
                    response = true
                    break
                end
            end

            fn(response)
        end,
        failed = function(err)
            error('HTTP Request Failed, steamweb:vac_banned -> ' .. err)
        end
    })
end

function steamweb:get_profile_key(steamid64, key, fn)
    HTTP({
        url = 'https://steamcommunity.com/profiles/'..steamid64..'/?xml=1',
        method = 'get',
        headers = {},
        success = function(code, body, header)
            if not body then error('Invalid steamweb:get_profile_key body! Code ' .. code) end
            body = body:Split('\n')

            local response
            for _, v in ipairs(body) do
                if v:find(key) then
                    response = v
                    break
                end
            end

            fn(response)
        end,
        failed = function(err)
            error('HTTP Request Failed, steamweb:get_profile_key -> ' .. err)
        end
    })
end

return steamweb