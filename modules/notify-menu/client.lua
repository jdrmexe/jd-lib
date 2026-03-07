-- ╔══════════════════════════════════════════════╗
-- ║       jd_lib · Noti-Menu Module             ║
-- ╚══════════════════════════════════════════════╝

if IsDuplicityVersion() then return end

local menuOpen = false

-- ── Toggle on /testnotify ──────────────────────────────────────
RegisterCommand('testnotify', function()
    if menuOpen then
        menuOpen = false
        SetNuiFocus(false, false)
        SendNUIMessage({ action = 'closeNotiMenu' })
    else
        menuOpen = true
        SetNuiFocus(true, true)
        SendNUIMessage({ action = 'openNotiMenu' })
    end
end, false)

-- ── NUI close callback (Esc or close button) ───────────────────
RegisterNUICallback('notiMenuClose', function(_, cb)
    cb('ok')
    menuOpen = false
    SetNuiFocus(false, false)
end)