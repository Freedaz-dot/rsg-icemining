local RSGCore = exports['rsg-core']:GetCoreObject()
-----------------------------------------------------------------------
-- version checker
-----------------------------------------------------------------------
local function versionCheckPrint(_type, log)
    local color = _type == 'success' and '^2' or '^1'

    print(('^5['..GetCurrentResourceName()..']%s %s^7'):format(color, log))
end

local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Rexshack-RedM/rsg-core/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return 
        end

        --versionCheckPrint('success', ('Current Version: %s'):format(currentVersion))
        --versionCheckPrint('success', ('Latest Version: %s'):format(text))
        
        if text == currentVersion then
            versionCheckPrint('success', 'You are running the latest version.')
        else
            versionCheckPrint('error', ('You are currently running an outdated version, please update to version %s'):format(text))
        end
    end)
end

-----------------------------------------------------------------------

local randomDeliveryIce

RegisterServerEvent('rsg-icemining:server:sellice')
AddEventHandler('rsg-icemining:server:sellice', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local price = 0
    local hasice = false
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if Player.PlayerData.items[k].name == "ice" then 
                    price =  price + (Config.PriceIce  * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("ice", Player.PlayerData.items[k].amount, k)
                    hasice = true
                end
            end
        end
        if hasice == true then
            Player.Functions.AddItem('cash', price, "ice-sold")
            TriggerClientEvent('ox_lib:notify', source, {title = Lang:t('lang_26'), description = Lang:t('lang_27')..price, type = 'success' })
            hasice = false
        else
            TriggerClientEvent('ox_lib:notify', source, {title = Lang:t('lang_28'), description = Lang:t('lang_29'), type = 'error' })
        end
    end
end)

-- give delivery reward
RegisterNetEvent('rsg-icemining:server:givereward', function(cashreward)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('cash',cashreward)
end)

-- give mining reward
RegisterServerEvent('rsg-icemining:server:giveMiningIceReward')
AddEventHandler('rsg-icemining:server:giveMiningIceReward', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local chance = math.random(1,100)
        if chance <= 80 then
            local item1 = Config.IceMiningRewards[math.random(1, #Config.IceMiningRewards)]
            -- add items
            Player.Functions.AddItem(item1, Config.SmallIceRewardAmount)
            TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
            TriggerClientEvent('ox_lib:notify', source, {title = Lang:t('lang_30'), description = Lang:t('lang_31'), type = 'primary' })
        elseif chance > 80 then -- large reward
            local item1 = Config.IceMiningRewards[math.random(1, #Config.IceMiningRewards)]
            local item2 = Config.IceMiningRewards[math.random(1, #Config.IceMiningRewards)]
            -- add items
            Player.Functions.AddItem(item1, Config.LargeIceRewardAmount)
            TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item1], "add")
            Player.Functions.AddItem(item2, Config.LargeIceRewardAmount)
            TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items[item2], "add")
            TriggerClientEvent('ox_lib:notify', source, {title = Lang:t('lang_32'), description = Lang:t('lang_33'), type = 'primary' })
        end
        TriggerEvent('rsg-log:server:CreateLog', 'mining', '🌟', 'yellow', firstname..' '..lastname..' Recibe: ' .. table.concat(Config.IceMiningRewards, ', '))

end)

-- remove pickaxe if broken
RegisterServerEvent('rsg-icemining:server:removeitem')
AddEventHandler('rsg-icemining:server:removeitem', function(item)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if item == 'pickaxe' then
        Player.Functions.RemoveItem('pickaxe', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, RSGCore.Shared.Items['pickaxe'], "add")
        RSGCore.Functions.Notify(src, 'your_pickaxe_broke', 'success')
        TriggerClientEvent('ox_lib:notify', source, {title = Lang:t('lang_8'), description = Lang:t('lang_9'), type = 'success' })
    else
        RSGCore.Functions.Notify(src, 'something_went_wrong', 'error')
        TriggerClientEvent('ox_lib:notify', source, {title = Lang:t('lang_34'), description = Lang:t('lang_35'), type = 'error' })
    end
end)

--------------------------------------------------------------------------------------------------
-- start version check
--------------------------------------------------------------------------------------------------
CheckVersion()