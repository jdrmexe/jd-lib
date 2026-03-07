-- ╔══════════════════════════════════════════════╗
-- ║       jd_lib · Gunpowder Detection           ║
-- ╚══════════════════════════════════════════════╝

if IsDuplicityVersion() then return end

local COOLDOWN    = 30000
local CLEAR_TIME  = 300000 -- 5 minutes

local lastTrigger = 0
local wasShooting = false

local ExemptWeapons = {
    [`WEAPON_STUNGUN`] = true
}

CreateThread(function()
    while true do
        Wait(100)

        local ped      = PlayerPedId()
        local now      = GetGameTimer()
        local shooting = IsPedShooting(ped)
        local weapon   = GetSelectedPedWeapon(ped)

        -- Ignore exempt weapons
        if ExemptWeapons[weapon] then
            wasShooting = shooting
            goto continue
        end

        if shooting and not wasShooting and (now - lastTrigger) >= COOLDOWN then
            lastTrigger = now

            lib.notify({
                title       = 'Smells of Gunpowder',
                description = 'You smell strongly of gunpowder.',
                type        = 'warning',
                duration    = 5000,
            })

            ExecuteCommand('playerObs Smells Of Gunpowder')

            -- Auto clear after 5 minutes
            SetTimeout(CLEAR_TIME, function()
                ExecuteCommand('playerObs')
            end)
        end

        ::continue::
        wasShooting = shooting
    end
end)