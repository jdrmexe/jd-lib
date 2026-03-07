-- ╔══════════════════════════════════════════════╗
-- ║      jd_lib · Player Join Notifications      ║
-- ╚══════════════════════════════════════════════╝

RegisterNetEvent('jd_lib:playerJoined')
AddEventHandler('jd_lib:playerJoined', function(name)
    lib.notify({
        title       = 'Player Joined',
        description = name .. ' has joined the server.',
        type        = 'success',
        duration    = 5000,
    })
end)