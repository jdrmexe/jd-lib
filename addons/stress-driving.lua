-- ╔══════════════════════════════════════════════╗
-- ║       jd_lib · Reckless Driving Warning      ║
-- ╚══════════════════════════════════════════════╝

if IsDuplicityVersion() then return end

local SPEED_LIMIT      = 70    -- mph threshold
local WARNING_INTERVAL = 30000 -- ms between repeat warnings while still speeding
local lastWarning      = 0

-- GTA native speed is in m/s, convert to mph
local function toMph(mps)
    return mps * 2.23694
end

CreateThread(function()
    while true do
        Wait(1000)

        local ped = PlayerPedId()

        -- only care if player is in a vehicle and is the driver
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)

            if GetPedInVehicleSeat(vehicle, -1) == ped then
                local speed = toMph(GetEntitySpeed(vehicle))
                local now   = GetGameTimer()

                if speed > SPEED_LIMIT and (now - lastWarning) >= WARNING_INTERVAL then
                    lastWarning = now

                    lib.notify({
                        title       = 'You are getting stressed',
                        description = 'You are driving to fast, slow down!',
                        type        = 'warning',
                        duration    = 5000,
                    })
                end

                -- reset cooldown when they drop back under the limit
                if speed <= SPEED_LIMIT then
                    lastWarning = 0
                end
            end
        end
    end
end)