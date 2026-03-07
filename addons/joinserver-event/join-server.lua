-- ╔══════════════════════════════════════════════╗
-- ║      jd_lib · Player Join Notifications      ║
-- ╚══════════════════════════════════════════════╝

AddEventHandler('playerJoining', function()
    local src  = source
    local name = GetPlayerName(src)

    if not name then return end

    -- broadcast to every connected player
    TriggerClientEvent('jd_lib:playerJoined', -1, name)
end)