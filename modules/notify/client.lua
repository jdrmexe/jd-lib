-- ╔══════════════════════════════════════════════╗
-- ║        JD Library  ·  Notify Module         ║
-- ╚══════════════════════════════════════════════╝

-- keep NUI in the background, never focused
CreateThread(function()
    while true do
        Wait(0)
        SetNuiFocus(false, false)
    end
end)

-- Export so external resources can call:
--   exports['jd_lib']:notify({ title = '...', type = 'success' })
exports('notify', function(options)
    lib.notify(options)
end)

-- Also export the whole lib table
exports('lib', function()
    return lib
end)

-- NUI callback (not really needed for notify, but good practice)
RegisterNUICallback('ready', function(_, cb)
    cb('ok')
end)
