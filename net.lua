local util_TableToJSON, util_JSONToTable = util.TableToJSON, util.JSONToTable
local util_Compress, util_Decompress = util.Compress, util.Decompress
local net_WriteUInt, net_WriteData = net.WriteUInt, net.WriteData
local net_ReadUInt, net_ReadData = net.ReadUInt, net.ReadData

function net.WriteCompressedTable(data)
    local json = util_TableToJSON(data)
    local compressed = util_Compress(json)
    local length = compressed:len()
    net_WriteUInt(length, 32)
    net_WriteData(compressed, length)
end

function net.ReadCompressedTable()
    local length = net_ReadUInt(32)
    return util_JSONToTable( util_Decompress( net_ReadData(length) ) )
end

function net.WritePlayer(client)
    if IsValid(client) then net_WriteUInt(client:EntIndex(), 8)
    else net_WriteUInt(0, 8)
    end
end

function net.ReadPlayer()
    local i = net_ReadUInt(8) if not i then return end
    return Entity(i)
end