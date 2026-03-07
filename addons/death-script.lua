-- ╔══════════════════════════════════════════════╗
-- ║         jd_lib · Death Notifications        ║
-- ╚══════════════════════════════════════════════╝

if IsDuplicityVersion() then return end

local isDead       = false
local cachedKiller = nil   -- cached before the source-of-death window closes

CreateThread(function()
    while true do
        Wait(0)   -- tight loop so we catch GetPedSourceOfDeath before it expires

        local ped  = PlayerPedId()
        local dead = IsEntityDead(ped) or IsPlayerDead(PlayerId())

        if dead and not isDead then
            isDead = true

            -- Read the killer immediately on the frame death is detected.
            -- This native is only valid for a very short window after death,
            -- so we cache it now before it disappears.
            if not cachedKiller then
                cachedKiller = resolveKiller(ped)
            end

            if cachedKiller then
                lib.notify({
                    title       = 'You Died',
                    description = 'Killed by ' .. cachedKiller.name .. ' (ID: ' .. cachedKiller.id .. ').',
                    type        = 'error',
                    duration    = 6000,
                })
            else
                lib.notify({
                    title       = 'You Died',
                    description = 'You have been killed.',
                    type        = 'warning',
                    duration    = 6000,
                })
            end

        elseif not dead and isDead then
            -- reset on respawn
            isDead       = false
            cachedKiller = nil
        end

        -- If dead but killer not found yet, keep trying each frame
        -- while the source-of-death window may still be open
        if dead and isDead and not cachedKiller then
            cachedKiller = resolveKiller(ped)
        end

        Wait(0)
    end
end)

-- ── Helper ─────────────────────────────────────────────────────
-- Returns { name, id } if the source of death is another player,
-- nil otherwise.

function resolveKiller(ped)
    local src = GetPedSourceOfDeath(ped)

    if not src or src == 0 then return nil end

    local players = GetActivePlayers()

    for _, playerId in ipairs(players) do
        if playerId ~= PlayerId() then
            local targetPed = GetPlayerPed(playerId)

            -- Direct kill — the killer ped is the source
            if targetPed == src then
                return {
                    name = GetPlayerName(playerId),
                    id   = GetPlayerServerId(playerId),
                }
            end

            -- Vehicle kill — source is a vehicle, check if this player is driving it
            if DoesEntityExist(src) and IsEntityAVehicle(src) then
                local driver = GetPedInVehicleSeat(src, -1)
                if driver ~= 0 and driver == targetPed then
                    return {
                        name = GetPlayerName(playerId),
                        id   = GetPlayerServerId(playerId),
                    }
                end
            end
        end
    end

    return nil
end