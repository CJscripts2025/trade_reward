local QBCore = exports['qb-core']:GetCoreObject()

local function notifyPlayer(src, type, title, description)
    if Config.NotificationSystem == 'ox' then
        TriggerClientEvent('ox_lib:notify', src, {
            type = type,
            title = title,
            description = description
        })
    elseif Config.NotificationSystem == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, description, type)
    end
end

RegisterNetEvent('reward:attemptClaim', function()
    local src = source
    local missing = {}
    local hasEnough = true

    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    for _, req in pairs(Config.Requirements.items) do
        local count
        if Config.InventorySystem == 'ox' then
            count = exports.ox_inventory:Search(src, 'count', req.name)
        elseif Config.InventorySystem == 'qb' then
            local item = player.Functions.GetItemByName(req.name)
            count = item and item.amount or 0
        end

        if count < req.count then
            table.insert(missing, ('%sx %s'):format(req.count - count, req.name))
            hasEnough = false
        end
    end

    local cash = Config.InventorySystem == 'ox'
        and exports.ox_inventory:Search(src, 'count', 'money')
        or player.Functions.GetMoney('cash')

    if cash < Config.Requirements.money then
        table.insert(missing, ('%s$ cash'):format(Config.Requirements.money - cash))
        hasEnough = false
    end

    if not hasEnough then
        notifyPlayer(src, 'error', 'Missing Requirements', 'You need: ' .. table.concat(missing, ', '))
        TriggerClientEvent('reward:missingConfirm', src)
        return
    end

    for _, req in pairs(Config.Requirements.items) do
        if Config.InventorySystem == 'ox' then
            exports.ox_inventory:RemoveItem(src, req.name, req.count)
        else
            player.Functions.RemoveItem(req.name, req.count)
        end
    end

    if Config.InventorySystem == 'ox' then
        exports.ox_inventory:RemoveItem(src, 'money', Config.Requirements.money)
    else
        player.Functions.RemoveMoney('cash', Config.Requirements.money)
    end

    for _, reward in pairs(Config.Reward.items) do
        if Config.InventorySystem == 'ox' then
            exports.ox_inventory:AddItem(src, reward.name, reward.count)
        else
            player.Functions.AddItem(reward.name, reward.count)
        end
    end

    if Config.Reward.money > 0 then
        if Config.InventorySystem == 'ox' then
            exports.ox_inventory:AddItem(src, 'money', Config.Reward.money)
        else
            player.Functions.AddMoney('cash', Config.Reward.money)
        end
    end

    notifyPlayer(src, 'success', 'Reward Claimed', 'You received your reward!')
end)
