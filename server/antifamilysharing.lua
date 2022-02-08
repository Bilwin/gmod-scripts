local PLAYER = FindMetaTable('Player')
function PLAYER:IsFamilyShared()
    return self:SteamID64() != self:OwnerSteamID64()
end

hook.Add('PlayerAuthed', 'antifamilysharing', function(client, steamid)
    if not client:IsFullyAuthenticated() then return end
    if client:IsFamilyShared() then client:Kick('anti-family sharing') end
end)