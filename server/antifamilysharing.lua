hook.Add('PlayerAuthed', 'antifamilysharing', function(client, steamid)
    if not client:IsFullyAuthenticated() then return end
    if steamid ~= client:OwnerSteamID64() then
        client:Kick()
    end
end)