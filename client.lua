local pedSpawned = false

CreateThread(function()
    if pedSpawned then return end
    pedSpawned = true

    local coords = vector3(Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z)
    local heading = Config.PedLocation.w

    RequestModel(Config.PedModel)
    while not HasModelLoaded(Config.PedModel) do Wait(0) end

    local ped = CreatePed(0, Config.PedModel, coords.x, coords.y, coords.z - 1.0, heading, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    local targetOptions = {
        {
            name = 'claim_reward',
            label = 'Claim Reward',
            icon = 'fas fa-gift',
            onSelect = function()
                TriggerServerEvent('reward:attemptClaim')
            end
        }
    }

    if Config.Target == 'ox' then
        exports.ox_target:addLocalEntity(ped, targetOptions)
    elseif Config.Target == 'qb' then
        exports['qb-target']:AddTargetEntity(ped, {
            options = targetOptions,
            distance = 2.5
        })
    end
end)

RegisterNetEvent('reward:showWaypointDialog', function()
    local result = lib.alertDialog({
        header = 'Recycling Center',
        content = 'You need to head to recycling.',
        centered = true,
        cancel = true
    })

    if result == 'confirm' then
        SetNewWaypoint(Config.RecyclingLocation.x, Config.RecyclingLocation.y)
    end
end)
