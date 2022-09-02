local net = net or {}

function net.WriteCompressedTable(tbl)
    local serialized = util.Compress( util.TableToJSON(tbl) )
    local length = serialized:len()
    net.WriteUInt(length, 32)
    net.WriteData(serialized, length)
end

function net.ReadCompressedTable()
    local length = net.ReadUInt(32)
    local unserialized = util.JSONToTable( util.Decompress( net.ReadData(length) ) )
    if not unserialized or next(unserialized) == nil then unserialized = {} end
    return unserialized
end

function net.WritePlayer(player)
    net.WriteUInt(player:UserID(), 16)
end

function net.ReadPlayer()
    return Player( net.ReadUInt(16) )
end